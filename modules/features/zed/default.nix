{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.zed = moduleWithSystem ({self', ...}: {
    environment.systemPackages = [
      self'.packages.zed
    ];
  });

  perSystem = {pkgs, ...}: {
    packages.zed = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.zed-editor;
      runtimePkgs = [
        pkgs.nil
        pkgs.nixd
        pkgs.kdePackages.qtdeclarative
      ];
    };
  };
}
