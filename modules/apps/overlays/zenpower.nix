final: prev:
{
  linuxPackages_zen = prev.linuxPackages_zen.extend(
    lfinal: lprev: {
      zenpower5 = prev.linuxPackages_zen.zenpower.overrideAttrs (_: {
        version = "0.5.0";
        src = prev.fetchFromGitHub {
          owner = "mattkeenan";
          repo = "zenpower5";
          rev = "66871d8e59c3741e00de2eb1f61c3b64263ed10b";
          hash = "sha256-g0zVTDi5owa6XfQN8vlFwGX+gpRIg+5q1F4EuxAk9Sk=";
        };
      });
    }
  );
}
