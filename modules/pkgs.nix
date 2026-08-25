{
  pkgs,
  nixpkgs-stable,
  device,
  inputs,
  ...
}:

let
  stable = import nixpkgs-stable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };

  globalPkgs = [
    pkgs.git
    pkgs.python3
    pkgs.rustc
    pkgs.rustPlatform.rustLibSrc
    pkgs.cargo
    pkgs.jdk25

    pkgs.btop

    pkgs.mpv

    pkgs.localsend
    pkgs.obsidian

    pkgs.nixfmt-tree
  ];

  nixosPkgs = [
    pkgs.compsize

    pkgs.kdePackages.dolphin
    pkgs.easyeffects
    (pkgs.ffmpeg-full.override { withUnfree = true; })

    pkgs.nvtopPackages.full
    pkgs.btop-cuda
    pkgs.furmark

    pkgs.jellyfin-mpv-shim

    pkgs.idea

    pkgs.libreoffice

    inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
    # .withOverrides {
    #   extraArgs = [
    #     "--enable-features=AcceleratedVideoDecodeLinuxGL,VaapiOnNvidiaGPUs"
    #     "--ignore-gpu-blocklist"
    #     "--use-gl=angle"
    #     "--use-angle=gl"
    #   ];
    # }
  ];

  macbookPkgs = [
    pkgs.appcleaner
    pkgs.betterdisplay
    pkgs.bitwarden-desktop
    pkgs.firefox
    pkgs.iina
    pkgs.iloader
    pkgs.keka
    pkgs.orion-browser
    pkgs.postman
    pkgs.vesktop
    pkgs.rstudio
    pkgs.tailscale-gui
    pkgs.transmission_4-mac
    pkgs.utm
    pkgs.vscode
    stable.prismlauncher
    pkgs.netbeans
    pkgs.jetbrains.idea
  ];
in

{
  environment.systemPackages =
    [ ]
    ++ globalPkgs
    ++ (
      if device == "nixos" then
        nixosPkgs
      else if device == "macbook" then
        macbookPkgs
      else
        [ ]
    );

  nixpkgs = {
    config.allowUnfree = true;
  };

  nixpkgs.overlays =
    if device != "macbook" then
      [
        (import apps/overlays/idea.nix)
      ]
    else
      [ ];
}
