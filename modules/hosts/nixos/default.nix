{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      nixos-configuration
      nixos-filesystems
      nixos-hardware

      desktop

      nvidia
    ];
  };
}
