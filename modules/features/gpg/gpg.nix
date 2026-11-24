{
  flake.nixosModules.gpg = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.gnupg
    ];

    programs.gnupg.agent = {
      enable = true;
    };
  };
}
