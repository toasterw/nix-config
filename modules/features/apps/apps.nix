{
  flake.nixosModules.apps = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      ladybird
      libreoffice
      localsend
      obsidian
    ];
  };
}
