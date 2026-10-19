{pkgs, ...}: {
  services.desktopManager.plasma6 = {
    enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    kate
    kwrited

    elisa
    dragon

    kalk
    kmail
    kontact
    korganizer
    kaddressbook
    kleopatra
    khelpcenter

    plasma-browser-integration

    konsole

    kpat

    discover
  ];

  security.pam.services.login.kwallet.enable = true;
}
