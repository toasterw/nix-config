{pkgs, ...}: {
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
  };

  environment.systemPackages = [
    pkgs.xvfb
    pkgs.xvfb-run
  ];
}
