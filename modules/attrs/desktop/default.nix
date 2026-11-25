{self, ...}: let
  imports = with self.nixosModules; [
    core
    gaming

    audio
    bluetooth
    fonts
    limine

    coolercontrol
    dev
    discord
    helium
    kde
    kitty
    kopuz
    ly
    obs
    sunshine
    zed
  ];
in {
  flake.nixosModules.desktop = {pkgs, ...}: {
    inherit imports;

    environment.systemPackages = with pkgs; [
      bubblewrap
      (ffmpeg-full.override {withUnfree = true;})
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
