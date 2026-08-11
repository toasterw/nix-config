{ username, ... }:

{
  home-manager.users.${username}.imports = [
    ./git.nix
    ./zsh.nix
  ];
}
