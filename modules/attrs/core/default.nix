{self, ...}: let
  imports = with self.nixosModules; [
    locale
    network
    nh
    nix
    openssh
    user

    git
    gpg
    zsh
  ];
in {
  flake.nixosModules.core = {
    pkgs,
    lib,
    config,
    ...
  }: {
    inherit imports;

    environment.systemPackages = with pkgs; [
      (
        if lib.elem "nvidia" config.services.xserver.videoDrivers
        then btop-cuda
        else btop
      )
      dysk
      fastfetch
      file
      fzf
      unzip
      zip
    ];
  };
}
