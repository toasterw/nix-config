{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.zsh = moduleWithSystem ({
    self',
    ...
  }: {
    programs.zsh = {
      enable = true;
      package = self'.packages.zsh;
    };
  });

  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.zsh = inputs.wrappers.wrappers.zsh.wrap {
      inherit pkgs;
      hmSessionVariables = null;
      runtimePkgs = [
        pkgs.fzf
        pkgs.zoxide
      ];
      zshAliases = {
        cat = lib.getExe pkgs.bat;
      };
      zshrc.content = ''
        export ZSH="${pkgs.oh-my-zsh}/share/oh-my-zsh"
        export ZSH_CACHE_DIR="''${XDG_CACHE_HOME:-$HOME/.cache}/oh-my-zsh"
        export ZSH_COMPDUMP="$ZSH_CACHE_DIR/.zcompdump"
        mkdir -p "$ZSH_CACHE_DIR"

        ZSH_THEME="robbyrussell"
        DISABLE_AUTO_UPDATE="true"
        plugins=(git)
        source "$ZSH/oh-my-zsh.sh"

        if [[ -n "$IN_NIX_SHELL" || "''${PATH%%:*}" == /nix/store/* ]]; then
          PROMPT="%{$fg_bold[blue]%} %{$reset_color%}$PROMPT"
        fi

        HISTFILE="$HOME/.zsh_history"
        HISTSIZE=10000
        SAVEHIST=10000
        setopt HIST_IGNORE_ALL_DUPS
        HISTORY_IGNORE="(rm *|pkill *|cp *)"

        alias ls="${lib.getExe pkgs.lsd}"
        alias ll="${lib.getExe pkgs.lsd} -l"

        f () {
          local -a COMMAND=(nix shell)
          local -a args=()
          local impure=0

          for arg in "$@"; do
            if [[ "$arg" == "-i" ]]; then
              impure=1
            else
              args+=("$arg")
            fi
          done

          if (( impure )); then
            export NIXPKGS_ALLOW_UNFREE=1
            COMMAND=(nix shell --impure)
          fi

          if [[ ''${#args[@]} -eq 0 ]]; then
            if [[ -f flake.nix ]]; then
              nix develop
            else
              nix-shell
            fi
          else
            "''${COMMAND[@]}" "''${args[@]/#/nixpkgs#}"
          fi
        }

        source "${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh"
        source "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
        source "${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh"

        source <(${lib.getExe pkgs.fzf} --zsh)
        eval "$(${lib.getExe pkgs.zoxide} init zsh --cmd cd)"

        source "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
      '';
    };
  };
}
