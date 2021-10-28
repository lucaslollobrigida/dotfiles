{ pkgs, ... }:

{
  home.packages = with pkgs; [ dunst libnotify ];

  xdg.configFile."dunst" = {
    source = ../conf/dunst;
    recursive = true;
  };
}
