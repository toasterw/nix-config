{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    helium.url = "github:clamlum/helium-flake";
  };
  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      mkSystem = nixpkgs.lib.nixosSystem;
      username = "toaster";
      nixConf = { nix.settings = {
        experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operators"
        ];
        auto-optimise-store = true;
      };};
    in
    {

      nixosConfigurations = {
        nixos =
          let
            device = "nixos";
          in
          mkSystem {
            system = "x86-64-linux";
            specialArgs = {
              inherit device username;
              inherit (inputs) nixpkgs-stable self;
              inherit inputs;
            };
          modules = [
            ./modules
            ./modules/apps
            ./modules/desktops/kde
            # ./modules/desktops/niri
            ./modules/desktops/dm
            ./modules/devices/pc
            ./modules/services
            ./modules/shell
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                sharedModules = [ inputs.plasma-manager.homeModules.plasma-manager ];
                extraSpecialArgs = {
                  inherit device username self;
                };
              };
            }
          ];
        };
      };
      nixConfig = { inherit nixConf; };
  };
}
