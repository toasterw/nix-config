{device, ...}: {
  imports =
    [
      ./fonts.nix
    ]
    ++ (
      if device == "nixos"
      then [
        ./audio.nix
        ./docker.nix
        ./ios.nix
        ./nh.nix
        # ./ollama.nix
        ./tailscale.nix
        ./sunshine.nix
        ./wings.nix
      ]
      else []
    );
}
