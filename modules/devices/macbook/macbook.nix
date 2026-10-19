{
  pkgs,
  self,
  username,
  nixpkgs-stable,
  ...
}: let
  stable = import nixpkgs-stable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in {
  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 6;

  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  environment.systemPackages = [
    stable.moonlight-qt
  ];

  system.primaryUser = username;

  home-manager.users.${username} = {
    home.stateVersion = "26.05";
    home.file.".hushlogin".text = "";
  };

  homebrew = {
    enable = true;

    casks = [
      "wine@staging"
    ];
  };
}
