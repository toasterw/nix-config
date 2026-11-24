{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.discord = moduleWithSystem ({self', ...}: {
    environment.systemPackages = [
      self'.packages.discord
    ];
  });

  perSystem = {pkgs, ...}: let
    discordPatcher = pkgs.writers.writePython3 "discord-krisp-patcher" {
      libraries = with pkgs.python3Packages; [
        pyelftools
        capstone
      ];
      flakeIgnore = [
        "E265" # from nix-shell shebang
        "E501" # line too long (82 > 79 characters)
        "F403" # ‘from module import *’ used; unable to detect undefined names
        "F405" # name may be undefined, or defined from star imports: module
      ];
    } (builtins.readFile ./krisp-patcher.py);

    baseDiscord = pkgs.discord.override {
      withVencord = true;
      # withOpenASAR = true;
    };

    patchedUnwrapped = baseDiscord.passthru.unwrappedDiscord.overrideAttrs (old: {
      postFixup =
        (old.postFixup or "")
        + ''
          ${pkgs.findutils}/bin/find "$out/opt/Discord/modules" \
            -name 'discord_krisp.node' -exec ${discordPatcher} {} \;
        '';
    });

    patchedDiscord = baseDiscord.override {
      unwrappedDiscord = patchedUnwrapped;
    };
  in {
    packages.discord = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = patchedDiscord;
      aliases = ["discord"];
    };
  };
}
