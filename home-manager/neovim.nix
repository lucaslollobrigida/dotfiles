{ config, lib, pkgs, ... }:

let
  myneovim = pkgs.unstable.neovim.override (
    {
      vimAlias = true;
      viAlias = false;
      withNodeJs = false;
      withRuby = false;
    }
  );
in
{
  home.packages = with pkgs; [ myneovim ];

  # programs.neovim = {
  #   enable = true;
  #   package = pkgs.unstable.neovim;

  #   viAlias = false;
  #   vimAlias = true;
  #   vimdiffAlias = true;

  #   withNodeJs = false;
  #   withRuby = false;
  # };

  programs.zsh.sessionVariables = {
    EDITOR = "nvim";
  };

  xdg.configFile."nvim" = {
    source = ../conf/vim/nvim;
    recursive = true;
  };

  xdg.dataFile."nvim/snippets" = {
    source = ../conf/vim/snippets;
    recursive = true;
  };
}
