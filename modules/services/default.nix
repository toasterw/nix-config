{ username, ... }:

{
  imports = [
    ./fonts.nix
  ]
  ++ (if device == "nixos" then
        [
          ./audio.nix
          ./gtk.nix
        ]
      else [ ]
  );
  home-manager.users.${username}.imports = [ ]
  ++ (if device == "nixos" then
    [
      ./icons.nix
    ]
    else [ ]
  )
}
