{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "lsd";
      ll = "lsd -l";
      rebuild = "sudo nixos-rebuild switch --flake /home/toaster/nix-config";
    };

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = ["rm *" "pkill *" "cp *"];

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
      theme = "robbyrussell";
    };
  };

  home.packages = [
    pkgs.zsh-you-should-use
    pkgs.zsh-nix-shell

    pkgs.lsd
    pkgs.bat
    pkgs.zoxide
    pkgs.file
  ];
}
