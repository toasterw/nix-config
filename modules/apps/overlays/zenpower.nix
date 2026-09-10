final: prev: {
  linuxPackages_zen = prev.linuxPackages_zen.extend (
    lfinal: lprev: {
      zenpower5 = prev.linuxPackages_zen.zenpower.overrideAttrs (_: {
        version = "0.5.0";
        src = prev.fetchFromGitHub {
          owner = "Artanejp";
          repo = "zenpower5";
          rev = "746c9af943c5aabdba132fed8473599f511b083b";
          hash = "sha256-Gecm9JGoYEOWZiVoBVmIj5zMB5izOT2x35+nEy+XXE8=";
        };
      });
    }
  );
}
