{
  pkgs,
  config,
  # lib,
  ...
}: {
  programs.coolercontrol.enable = true;

  environment.systemPackages = [
    pkgs.liquidctl
    pkgs.lm_sensors
    pkgs.linuxPackages_latest.zenpower
    pkgs.linuxPackages_latest.it87
  ];
}
