{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.kitty = moduleWithSystem ({self', ...}: {
    environment.systemPackages = [
      self'.packages.kitty
    ];
  });
  perSystem = {pkgs, ...}: {
    packages.kitty = inputs.wrappers.wrappers.kitty.wrap {
      inherit pkgs;
      themeFile = "rose-pine";
      font.name = "JetBrains Mono Nerd Font";
      font.size = 12;
    };
  };
}
