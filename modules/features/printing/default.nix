{
  flake.nixosModules.printing = {
    pkgs,
    config,
    ...
  }: {
    services.printing = {
      enable = true;
      drivers = [
        pkgs.cnijfilter2
      ];
    };

    hardware.sane.enable = true;

    users.users.${config.user.name}.extraGroups = [
      "scanner"
      "lp"
    ];
  };
}
