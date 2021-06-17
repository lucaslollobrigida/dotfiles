{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    viAlias = false;
    vimAlias = true;
    vimdiffAlias = true;

    withNodeJs = false;
    withRuby = false;
  };

  programs.zsh.sessionVariables = {
    EDITOR = "nvim";
  };

  xdg.configFile."nvim" = {
    source = ../conf/vim/.config/nvim;
    recursive = true;
  };

  xdg.dataFile."nvim" = {
    source = ../conf/vim/.local/share/nvim;
    recursive = true;
  };
}
