{ config, pkgs, ... }:

let
  inherit (config.lib.formats.rasi) mkLiteral;
in {
  programs.rofi = {
    enable = true;
    extraConfig = {
      show-icons = true;
      icon-theme = "candy-icons";
    };
  };

  xdg.configFile."rofi/launcher" = {
    source = ../conf/rofi/.config/rofi/launcher;
    recursive = true;
  };

  xdg.configFile."rofi/powermenu" = {
    source = ../conf/rofi/.config/rofi/powermenu;
    recursive = true;
  };
}

