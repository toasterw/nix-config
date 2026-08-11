{ device, username, ... }:
{
  home-manager.users.${username}.imports =
    if device == "nixos" then
    [
      ./ghostty.nix
      ./kitty.nix
      ./wezterm.nix
    ]
    else [ ./ghostty.nix ];

}
