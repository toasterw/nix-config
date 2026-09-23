{ device, ... }:

{
  imports = [
    ./gpg.nix
    ./kopuz.nix
    ./zed.nix

    ./terminals
  ]
  ++ (
    if device == "nixos" then
      [
        ./coolercontrol.nix
        ./discord.nix
        ./firefox.nix
        ./gaming.nix
        ./obs.nix
        ./seanime.nix
        ./virtualisation.nix
      ]
    else
      [ ]
  );

}
