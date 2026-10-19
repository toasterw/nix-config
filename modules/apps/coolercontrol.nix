{
  pkgs,
  # config,
  # lib,
  ...
}: {
  programs.coolercontrol.enable = true;

  environment.systemPackages = [
    pkgs.liquidctl
    pkgs.lm_sensors
    pkgs.linuxPackages_zen.zenpower
    pkgs.linuxKernel.packages.linux_zen.it87
  ];

  nixpkgs.overlays = [
    (import overlays/zenpower.nix)
  ];
}
