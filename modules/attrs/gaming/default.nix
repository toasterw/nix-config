{moduleWithSystem, ...}: {
  flake.nixosModules.gaming = moduleWithSystem (
    {self', ...}: {pkgs, ...}: {
      environment.systemPackages = [
        self'.packages.lutris
        pkgs.mangohud
        pkgs.owmods-gui
        pkgs.prismlauncher
        pkgs.protonup-qt
        # pkgs.steamtinkerlaunch
        pkgs.wineWow64Packages.stable
        pkgs.winetricks
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
  );
}
