{ username, ... }:

{
  home-manager.users.${username}.imports = [
    ./zsh.nix
  ];
}
