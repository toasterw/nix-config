{
  pkgs,
  lib,
  ...
}:

let
  pname = "seanime-denshi";
  version = "3.10.3";

  src = pkgs.fetchurl {
    url = "https://github.com/5rahim/seanime/releases/download/v${version}/${pname}-${version}_Linux_x86_64.AppImage";
    hash = "sha256-dcjehaA+vTf3S8uP7ucQxwBOD9Z+RKFoi11oVX8pHlw=";
  };

  appimageContents = pkgs.appimageTools.extract {
    inherit pname version src;
  };

  seanimeDenshi = pkgs.appimageTools.wrapType2 {
    inherit pname version src;

    extraInstallCommands = ''
      install -m 444 -D \
        ${appimageContents}/usr/share/icons/hicolor/439x439/apps/seanime-denshi.png \
        $out/share/icons/hicolor/512x512/apps/seanime-denshi.png

      install -m 444 -D /dev/stdin \
        $out/share/applications/seanime-denshi.desktop <<EOF
      [Desktop Entry]
      Name=Seanime Denshi
      Comment=Desktop client for the Seanime media server
      Exec=seanime-denshi %U
      Icon=seanime-denshi
      Terminal=false
      Type=Application
      Categories=Network;AudioVideo;Video;
      EOF
    '';

    meta = {
      description = "Desktop client for the Seanime media server";
      homepage = "https://github.com/5rahim/seanime";
      license = lib.licenses.gpl3Plus;
      mainProgram = pname;
      platforms = [ "x86_64-linux" ];
    };
  };
in
{
  environment.systemPackages = [ seanimeDenshi ];
}
