{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    kopuz.url = "github:kopuz-org/kopuz";
    helium = {
      url = "github:clamlum/helium-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/4.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wings = {
      url = "github:toasterw/wings-flake";
    };
  };
  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    ...
  } @ inputs: let
    mkSystem = nixpkgs.lib.nixosSystem;
  in {
    nixosConfigurations = {
      nixos = let
        device = "nixos";
        username = "toaster";
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
            ./modules/desktops/dm
            ./modules/desktops/kde
            ./modules/desktops/niri
            # ./modules/desktops/xfce
            ./modules/devices/pc
            ./modules/services
            ./modules/shell
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                sharedModules = [inputs.plasma-manager.homeModules.plasma-manager];
                extraSpecialArgs = {
                  inherit device username self;
                };
              };
            }
          ];
        };
    };
    darwinConfigurations."Ethans-MacBook-Pro" = let
      device = "macbook";
      username = "ethansharp";
    in
      nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit device;
          inherit username;
          inherit (inputs) nixpkgs-stable self;
          inherit inputs;
        };
        modules = [
          ./modules
          ./modules/apps
          ./modules/devices/macbook
          ./modules/shell
          ./modules/services/fonts.nix
          inputs.home-manager.darwinModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {
                inherit device username self;
              };
            };
          }
        ];
      };
    nixConfig = {
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
      auto-optimise-store = true;
    };
  };
}
