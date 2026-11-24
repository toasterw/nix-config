{inputs, ...}: {
  perSystem = {system, ...}: {
    _module.args = {
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      stablePkgs = import inputs.nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
    };
  };

  flake.nixosModules.nix = {...}: {
    programs.nix-ld.enable = true;

    nixpkgs.config.allowUnfree = true;

    nix.settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    system.stateVersion = "26.05";
  };
}
