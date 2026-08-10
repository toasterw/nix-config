{ pkgs, ... }:

{
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  environment.systemPackages = [
    pkgs.xwayland-satellite
  ];
}
