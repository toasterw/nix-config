{ device, ... }:

{
  imports = [
    ./fonts.nix
  ]
  ++ (
    if device == "nixos" then
      [
        ./audio.nix
        ./docker.nix
        ./ios.nix
        # ./ollama.nix
        ./tailscale.nix
        ./sunshine.nix
        ./wings.nix
      ]
    else
      [ ]
  );
}
