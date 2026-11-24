{...}: {
  flake.nixosModules.limine = {pkgs, ...}: {
    boot.loader = {
      limine = {
        enable = true;
        secureBoot = {
          enable = true;
        };
      };
      efi.canTouchEfiVariables = true;
    };

    environment.systemPackages = [
      pkgs.sbctl
    ];
  };
}
