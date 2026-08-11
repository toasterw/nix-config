{
  programs.git = {
    enable = true;
    settings = {
      user.name = "toasterw";
      user.email = "71234319+toasterw@users.noreply.github.com";
      gpg.format = "openpgp";
    };

    signing = {
      signByDefault = true;
    };

    ignores = [ ".DS_Store" "._.DS_Store" ];
  };
}
