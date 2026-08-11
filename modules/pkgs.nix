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
   globalPkgs = [
     pkgs.git
     pkgs.python3
     pkgs.rustc
     pkgs.rustPlatform.rustLibSrc
     pkgs.cargo
     pkgs.jdk25

     pkgs.btop

     pkgs.mpv
     pkgs.kopuz

     pkgs.localsend
     pkgs.obsidian

     pkgs.nixfmt-tree
   ]

   nixosPkgs = [
     pkgs.compsize

     pkgs.kdePackages.dolphin
     pkgs.easyeffects
     (pkgs.ffmpeg-full.override { withUnfree = true; })

     pkgs.nvtopPackages.full
     pkgs.btop-cuda
     pkgs.furmark

     pkgs.idea

     inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
     # .withOverrides {
     #   extraArgs = [
     #     "--enable-features=AcceleratedVideoDecodeLinuxGL,VaapiOnNvidiaGPUs"
     #     "--ignore-gpu-blocklist"
     #     "--use-gl=angle"
     #     "--use-angle=gl"
     #   ];
     # }
   ]

   macbookPkgs = [
     ghostty-bin
   ]

  ];

  nixpkgs = {
    config.allowUnfree = true;
  };

  nixpkgs.overlays =
    if device != "macbook" then [
      (import apps/overlays/idea.nix)
    ] else [ ];
}
