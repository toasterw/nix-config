{ device, ... }:

{
  imports = [
    ./fonts.nix
  ]
  ++ (
    if device == "nixos" then
      [
        ./audio.nix
        # ./docker.nix
        # ./ollama.nix
        ./tailscale.nix
      ]
    else
      [ ]
  );
}
