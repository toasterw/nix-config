{
  flake.nixosModules.apps = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      jellyfin-mpv-shim
      ladybird
      libreoffice
      localsend
      losslesscut
      mpv
      obsidian
    ];
  };
}
