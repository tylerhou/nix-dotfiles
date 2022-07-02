{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    shellAliases = {
      "vim" = "nvim";
      "ls" = "ls --color=auto";
      # TODO: 256 colors do not work unless we set TERM here.
      "tmux" = "TERM=xterm-256color tmux -2";
    };

    # TODO: Enable when home-manager/pull/2144 is backported.
    # enableSyntaxHighlighting = true;

    sessionVariables = {
      "EDITOR" = "nvim";
      "NIX_PATH" = "$HOME/.nix-defexpr/channels\${NIX_PATH:+:}$NIX_PATH";
    };

    oh-my-zsh = {
      enable = true;
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

      ssh-check-agent () {
        if [ ! -S ~/.ssh/ssh_auth_sock ]; then
          eval `ssh-agent`
          ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
        fi
        export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
        ssh-add -l > /dev/null || ssh-add
      }

      ssh-check-agent
    '';
  };

  home.packages = [
    pkgs.zsh-syntax-highlighting
  ];
}
