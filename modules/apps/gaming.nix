{
  pkgs,
  nixpkgs-stable,
  ...
}: let
  stable = import nixpkgs-stable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in {
  environment.systemPackages = [
    stable.lutris
    pkgs.protonup-qt
    pkgs.prismlauncher
    pkgs.jdk25
    pkgs.mangohud
    # pkgs.steamtinkerlaunch
    pkgs.wineWow64Packages.stable
    pkgs.winetricks
    pkgs.owmods-gui
  ];

  programs.moonlight-qt.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    protontricks.enable = true;
    # gamescopeSession.enable = true;
  };

  programs.gamescope = {
    enable = true;
    enableWsi = true;
    capSysNice = true;
  };
}
