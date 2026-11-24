{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    wrappers.url = "github:nix-community/nix-wrapper-modules";

    kopuz.url = "github:kopuz-org/kopuz";
    helium = {
      url = "github:clamlum/helium-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wings = {
      url = "github:toasterw/wings-flake";
    };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake
    {inherit inputs;}
    (inputs.import-tree ./modules);
}
