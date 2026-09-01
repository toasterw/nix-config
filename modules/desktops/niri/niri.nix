{ pkgs, ... }:

{
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  environment.systemPackages = [
    pkgs.xwayland-satellite

    pkgs.waybar
    pkgs.swaybg
    pkgs.mako

    pkgs.rofi

    pkgs.grim
    pkgs.slurp
    pkgs.satty

    pkgs.kdePackages.polkit-kde-agent-1
    pkgs.cliphist
  ];
}
