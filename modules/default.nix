{ username, ... }:
{
  imports = [
    ./configuration.nix
    ./pkgs.nix
  ];
  home-manager.users.${username}.imports = [
    ./home.nix
  ];
}
