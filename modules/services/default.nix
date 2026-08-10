{ username, ... }:

{
  imports = [
    ./audio.nix
    ./fonts.nix
    ./gtk.nix
  ];
  home-manager.users.${username}.imports = [
    ./icons.nix
  ];
}
