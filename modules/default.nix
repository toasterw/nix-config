{ device, username, ... }:
{
  imports =
  [ ] ++ (if device == "nixos" then
  [
    ./configuration.nix
    ./pkgs.nix
  ]
  else [ ]);
  home-manager.users.${username}.imports =
  [ ] ++ (if device != "macbook" then [ ./home.nix ] else [ ]);
}
