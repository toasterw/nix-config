{ device, username, ... }:
{
  imports =
  [
    ./pkgs.nix
  ] ++ (if device == "nixos" then
    [
      ./configuration.nix
    ]
  else [ ]);
  home-manager.users.${username}.imports =
  [ ] ++ (if device != "macbook" then [ ./home.nix ] else [ ]);
}
