{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    shellAliases = {
      "vim" = "nvim";
      "ls" = "ls --color=auto";
      "tmux" = "tmux -2";
    };

    # TODO: Enable when home-manager/pull/2144 is backported.
    # enableSyntaxHighlighting = true;

    sessionVariables = {
      "EDITOR" = "nvim";
      "TERM" = "screen-256color";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };

    initExtra = ''
      autoload -U promptinit; promptinit
      prompt pure

      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

      cdfd () {
        local dir
        dir=$(find ''${1:-.} -path '*/\.*' -prune \
                        -o -type d -print 2> /dev/null | fzf +m) &&
        cd "$dir"
      }

      cdgr () {
        local dir
        dir=$(git rev-parse --show-toplevel 2> /dev/null)
        if [ -z $dir ]; then
          cd .
        else
          cd $dir
        fi
      }

      bindkey "^P" up-line-or-search
      bindkey "^N" down-line-or-search
    '';
  };

  home.packages = [
    pkgs.zsh-syntax-highlighting
  ];
}
