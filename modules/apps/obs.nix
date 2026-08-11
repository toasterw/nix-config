{ device, pkgs, ... }:

{
  programs.obs-studio = {
    enable = true;

    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
      obs-gstreamer
      obs-vkcapture
    ];
  };

  environment.systemPackages = [
    pkgs.libva-vdpau-driver
    pkgs.libva-utils
    (pkgs.ffmpeg-full.override { withUnfree = true; })
  ];
}
