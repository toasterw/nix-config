{...}: {
  flake.nixosModules.audio = {
    pkgs,
    config,
    ...
  }: {
    security.rtkit.enable = true;

    services.pulseaudio.enable = false;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    environment.systemPackages = [
      pkgs.alsa-utils
      pkgs.easyeffects
      pkgs.pavucontrol
      pkgs.wireplumber
    ];

    security.pam.loginLimits = [
      {
        domain = "@audio";
        item = "rtprio";
        type = "soft";
        value = "95";
      }
      {
        domain = "@audio";
        item = "rtprio";
        type = "hard";
        value = "95";
      }
      {
        domain = "@audio";
        item = "memlock";
        type = "soft";
        value = "unlimited";
      }
      {
        domain = "@audio";
        item = "memlock";
        type = "hard";
        value = "unlimited";
      }
    ];

    users.users.${config.user.name}.extraGroups = ["audio"];

    boot.kernel.sysctl = {
      "kernel.sched_rt_runtime_us" = -1;
    };
  };
}
