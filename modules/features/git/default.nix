{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.git = moduleWithSystem ({self', ...}: {
    programs.git = {
      enable = true;
      package = self'.packages.git;
    };
  });

  perSystem = {pkgs, ...}: {
    packages.git = inputs.wrappers.wrappers.git.wrap ({config, ...}: {
      inherit pkgs;

      constructFiles.gitignore = {
        relPath = "gitignore";
        content = ''
          .DS_Store
          ._.DS_Store
        '';
      };

      settings = {
        user = {
          name = "toasterw";
          email = "71234319+toasterw@users.noreply.github.com";
        };
        gpg.format = "openpgp";
        commit.gpgSign = true;
        tag.gpgSign = true;
        core.excludesFile = config.constructFiles.gitignore.path;
      };
    });
  };
}
