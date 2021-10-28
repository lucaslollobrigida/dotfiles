{ config, pkgs, ... }:

let inherit (config.lib.formats.rasi) mkLiteral;
in {
  programs.rofi = {
    enable = true;
    font = "JetBrainsMono Nerd Font 14";
    lines = 15;
    scrollbar = false;
    padding = 30;
    separator = "none";
    colors = {
      window = {
        background = "#1D1D1D";
        border = "#1D1D1D";
        separator = "#1D1D1D";
      };

      rows = {
        normal = {
          background = "#1D1D1D";
          foreground = "#7b745b";
          backgroundAlt = "#1D1D1D";
          highlight = {
            background = "#3B2B2C";
            foreground = "#7b745b";
          };
        };
      };
    };

    extraConfig = {
      show-icons = true;
      show-match = false;
      fake-transparency = false;
      combi-hide-mode-prefix = false;

      icon-theme = "candy-icons";
      window-format = "[{w}] ··· {c} ···   {t}";

      display-window = "";
      display-windowcd = "";
      display-run = "";
      display-ssh = "";
      display-drun = "";
      display-combi = "";
    };
  };
}
