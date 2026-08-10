{ device, username, ... }:
{
  home-manager.users.${username}.imports = [
    ./ghostty.nix
    ./kitty.nix
    ./wezterm.nix
  ];
}
