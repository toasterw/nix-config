{...}: {
  flake.nixosModules.nh = {config, ...}: {
    programs.nh = {
      enable = true;
      flake = "/home/${config.user.name}/nix-config";
    };
  };
}
