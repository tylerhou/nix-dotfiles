{ config, pkgs, lib, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "tylerhou";
  home.homeDirectory = "/Users/tylerhou";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  home.packages = [
    pkgs.nodejs
    pkgs.pure-prompt
    pkgs.corefonts
    pkgs.texlive.combined.scheme-full
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "corefonts"
  ];

  imports = [
    ./fonts.nix
    ./programs/alacritty/default.nix
    ./programs/fzf/default.nix
    ./programs/git/default.nix
    ./programs/neovim/default.nix
    ./programs/tmux/default.nix
    ./programs/zsh/default.nix
  ];
}
