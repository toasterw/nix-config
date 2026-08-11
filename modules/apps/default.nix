{ device, ... }:

{
  imports = [
    ./gpg.nix
    ./zed.nix

    ./terminals
  ]
  ++ (if device == "nixos" then [
    ./coolercontrol.nix
    ./discord.nix
    ./firefox.nix
    ./gaming.nix
    ./obs.nix
  ] else [ ]
  );

}
