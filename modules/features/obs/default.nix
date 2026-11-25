{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.obs = moduleWithSystem (
    {self', ...}: {pkgs, ...}: {
      environment.systemPackages = [
        self'.packages.obs
        pkgs.libva-vdpau-driver
        pkgs.libva-utils
        (pkgs.ffmpeg-full.override {withUnfree = true;})
      ];
    }
  );

  perSystem = {pkgs, ...}: {
    packages.obs = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package =
        (pkgs.wrapOBS.override {
          obs-studio = pkgs.obs-studio.override {
            cudaSupport = true;
          };
        }) {
          plugins = with pkgs.obs-studio-plugins; [
            wlrobs
            obs-pipewire-audio-capture
            obs-gstreamer
            obs-vkcapture
          ];
        };
      runtimePkgs = [
        (pkgs.ffmpeg-full.override {withUnfree = true;})
      ];
    };
  };
}
