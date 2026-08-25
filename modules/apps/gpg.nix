{ device, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.gnupg
  ]
  ++ (if device == "macbook" then [ pkgs.pinentry_mac ] else [ ]);

  programs.gnupg.agent = {
    enable = true;
  };
}
