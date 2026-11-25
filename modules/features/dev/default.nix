{
  flake.nixosModules.dev = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      alejandra
      antigravity-cli
      cargo
      jdk25
      jetbrains.idea
      nixfmt-tree
      python3
      rustc
      rustPlatform.rustLibSrc
    ];
  };
}
