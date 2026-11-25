{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.librepods = moduleWithSystem ({self', ...}: {
    environment.systemPackages = [
      self'.packages.librepods
    ];
  });

  perSystem = {pkgs, ...}: {
    packages.librepods = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.librepods;
      overrides = [
        {
          type = "overrideAttrs";
          data = old: {
            src = pkgs.fetchFromGitHub {
              owner = "librepods-org";
              repo = "librepods";
              tag = "v1.0.4";
              hash = "sha256-R84mSviNoDAh5uQhUKBnsOf850E8fCHvDlWKWCBtZF4=";
            };
          };
        }
      ];
    };
  };
}
