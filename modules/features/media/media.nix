{
  flake.nixosModules.media = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      (ffmpeg-full.override {withUnfree = true;})
      jellyfin-mpv-shim
      losslesscut
      mpv
    ];
  };
}
