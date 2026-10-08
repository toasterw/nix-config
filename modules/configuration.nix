{ pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  services.openssh.enable = true;

  time.timeZone = "Pacific/Auckland";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_NZ.UTF-8";
    LC_IDENTIFICATION = "en_NZ.UTF-8";
    LC_MEASUREMENT = "en_NZ.UTF-8";
    LC_MONETARY = "en_NZ.UTF-8";
    LC_NAME = "en_NZ.UTF-8";
    LC_NUMERIC = "en_NZ.UTF-8";
    LC_TIME = "en_NZ.UTF-8";
  };

  programs.zsh.enable = true;

  users.users.toaster = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "uinput"
      "input"
    ];
    shell = pkgs.zsh;
  };

  system.stateVersion = "26.05";
}
