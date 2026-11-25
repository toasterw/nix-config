{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.kopuz = moduleWithSystem ({self', ...}: {
    nix.settings = {
      substituters = ["https://kopuz.cachix.org"];
      trusted-public-keys = [
        "kopuz.cachix.org-1:J2X3AnAYhKTJW5S3aCLoA1ckonQXVNZMQvhZA0YAufw="
      ];
    };

    environment.systemPackages = [
      self'.packages.kopuz
    ];
  });

  perSystem = {
    pkgs,
    system,
    ...
  }: {
    packages.kopuz = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = inputs.kopuz.packages.${system}.default;
    };
  };
}
