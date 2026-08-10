{
  pkgs,
  nixpkgs-stable,
  inputs,
  ...
}:

let
  stable = import nixpkgs-stable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in

{
 environment.systemPackages = [
    pkgs.git
    pkgs.python3
    pkgs.rustc
    pkgs.rustPlatform.rustLibSrc
    pkgs.cargo

    pkgs.nvtopPackages.full
    pkgs.btop
    pkgs.btop-cuda
    pkgs.compsize

    pkgs.mpv
    (pkgs.ffmpeg-full.override { withUnfree = true; })
    pkgs.kopuz

    pkgs.localsend
    pkgs.obsidian
    pkgs.kdePackages.dolphin

    pkgs.furmark

    pkgs.jdk25
    pkgs.idea

    pkgs.easyeffects

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

  nixpkgs = {
    config.allowUnfree = true;
  };

  nixpkgs.overlays = [
    (import apps/overlays/idea.nix)
  ];
}
