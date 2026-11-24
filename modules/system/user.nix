{...}: {
  flake.nixosModules.user = {
    pkgs,
    lib,
    config,
    ...
  }: {
    options.user.name = lib.mkOption {
      type = lib.types.str;
      description = "Primary user account name.";
    };

    config.users.users.${config.user.name} = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "uinput"
        "input"
      ];
      shell = pkgs.zsh;
    };
  };
}
