{ device, username, ... }:

{
  imports = [
    ./fonts.nix
  ]
  ++ (if device == "nixos" then
        [
          ./audio.nix
          ./docker.nix
          ./gtk.nix
          ./tailscale.nix
        ]
      else [ ]
  );
  home-manager.users.${username}.imports = [ ]
  ++ (if device == "nixos" then
    [
      ./icons.nix
    ]
    else [ ]
  );
}
