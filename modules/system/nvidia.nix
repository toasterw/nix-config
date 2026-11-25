{
  self,
  ...
}: {
  flake.nixosModules.nvidia = {
    pkgs,
    config,
    ...
  }: {
    imports = with self.nixosModules; [
      nvidia-vaapi-driver
    ];

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };

      nvidia = {
        modesetting.enable = true;
        powerManagement.enable = true;
        powerManagement.finegrained = false;

        open = true;

        nvidiaSettings = true;

        package = config.boot.kernelPackages.nvidiaPackages.latest;
      };
    };

    services.xserver.videoDrivers = ["nvidia"];

    environment.sessionVariables = {
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };

    environment.systemPackages = [
      pkgs.furmark
      pkgs.nvidia_oc
      pkgs.nvtopPackages.full
    ];

    systemd.services.nvidia-oc = {
      enable = true;
      description = "NVIDIA Overclocking Service";
      unitConfig = {
        after = "network.target";
      };
      serviceConfig = {
        ExecStart = "${pkgs.nvidia_oc}/bin/nvidia_oc set --index 0 --power-limit 400000 --freq-offset 350 --mem-offset 6000";
        User = "root";
        Restart = "on-failure";
      };
      wantedBy = ["multi-user.target"];
    };
  };
}
