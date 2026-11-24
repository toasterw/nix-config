{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.helium = moduleWithSystem ({self', ...}: {
    environment.systemPackages = [
      self'.packages.helium
    ];
  });

  perSystem = {
    pkgs,
    system,
    ...
  }: {
    packages.helium = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = inputs.helium.packages.${system}.default;
    };
  };
}
