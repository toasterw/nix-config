{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    import-tree = {url = "github:vic/import-tree";};

    wrappers = {
      url = "github:nix-community/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kopuz = {
      url = "github:kopuz-org/kopuz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
      url = "github:clamlum/helium-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wings = {
      url = "github:toasterw/wings-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake
    {inherit inputs;}
    (inputs.import-tree ./modules);
}
