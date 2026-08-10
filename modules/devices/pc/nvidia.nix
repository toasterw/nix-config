{ pkgs, config, ... }:

{
  hardware.graphics = {
    enable = true;
    extraPackages = [ pkgs.nvidia-vaapi-driver ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = true;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  services.xserver.videoDrivers = ["nvidia"];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVERS_PATH = "/run/opengl-driver/lib/dri";
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json";
  };

  nixpkgs.overlays = [
    (import ../../apps/overlays/nvidia-vaapi-driver.nix)
  ];

  environment.systemPackages = [
    pkgs.nvidia_oc
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
    wantedBy = [ "multi-user.target" ];
  };


}
