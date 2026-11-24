{...}: {
  flake.nixosModules.openssh = {config, ...}: {
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    users.users.${config.user.name}.openssh.authorizedKeys.keys = [
      # "ssh-ed25519 AAAA... user@host"
    ];
  };
}
