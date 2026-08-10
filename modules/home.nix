{ ... }:

{
  home.username = "toaster";
  home.homeDirectory = "/home/toaster";
  home.stateVersion = "26.05";

  home.file.".config/nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';

  home.file.".config/nixpkgs/config.nix".text = ''
    {
      allowUnfree = true;
    }
  '';
}
