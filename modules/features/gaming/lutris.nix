{inputs, ...}: {
  perSystem = {
    pkgs,
    stablePkgs,
    ...
  }: {
    packages.lutris = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = stablePkgs.lutris;
    };
  };
}
