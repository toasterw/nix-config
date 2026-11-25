{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.coolercontrol = moduleWithSystem (
    {self', ...}: {
      pkgs,
      config,
      ...
    }: {
      nixpkgs.overlays = [
        (final: prev: {
          coolercontrol =
            prev.coolercontrol
            // {
              coolercontrol-gui = self'.packages.coolercontrol;
            };
        })
      ];

      programs.coolercontrol.enable = true;

      environment.systemPackages = [
        pkgs.liquidctl
        pkgs.lm_sensors
        config.boot.kernelPackages.zenpower
        config.boot.kernelPackages.it87
      ];
    }
  );

  perSystem = {pkgs, ...}: {
    packages.coolercontrol = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.coolercontrol.coolercontrol-gui;
      runtimePkgs = [
        pkgs.liquidctl
        pkgs.lm_sensors
      ];
    };
  };
}
