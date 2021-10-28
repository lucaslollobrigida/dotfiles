{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ alacritty kitty font-manager ];

  programs.kitty = {
    enable = true;
    font = {
      name = ''"JetBrainsMono Nerd Font"'';
      size = 14;
    };

    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+f>2" = "set_font_size 20";
    };

    settings = {
      clipboard_control = "write-clipboard write-primary no-append";

      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;

      background = "#191622";
      foreground = "#F8F8F2";
      selection_foreground = "#f8f8f2";
      selection_background = "#E1E1E6";

      # black
      color0 = "#000000";
      color8 = "#4d4d4d";

      # red
      color1 = "#ff5555";
      color9 = "#ff6e67";

      # green
      color2 = "#50fa7b";
      color10 = "#5af78e";

      # yellow
      color3 = "#effa78";
      color11 = "#eaf08d";

      # blue
      color4 = "#bd93f9";
      color12 = "#caa9fa";

      # magenta
      color5 = "#FF79C6";
      color13 = "#FF92DF";

      # cyan
      color6 = "#8d79ba";
      color14 = "#aa91e3";

      # white
      color7 = "#bfbfbf";
      color15 = "#e6e6e6";
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "alacritty";
      window.padding = {
        x = 2;
        y = 2;
        dynamic_padding = true;
        decoration = "none";
      };

      font = {
        size = 12;
        normal = {
          family = "JetBrainsMono Nerd Font";
          # family = "Font Awesome 5 Free Solid";
        };
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "bold";
          # family = "Font Awesome 5 Free Solid";
        };

        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "italic";
          # family = "Font Awesome 5 Free Solid";
        };
      };

      colors = {
        primary = {
          background = "0x181a20";
          foreground = "0xeeffff";
        };

        cursor = {
          background = "0x212121";
          foreground = "0xeeffff";
        };

        normal = {
          black = "0x212121";
          red = "0xf07178";
          green = "0xc3e88d";
          yellow = "0xffcb6b";
          blue = "0x82aaff";
          magenta = "0xc792ea";
          cyan = "0x89ddff";
          white = "0xeeffff";
        };

        bright = {
          black = "0x4a4a4a";
          red = "0xf07178";
          green = "0xc3e88d";
          yellow = "0xffcb6b";
          blue = "0x82aaff";
          magenta = "0xc792ea";
          cyan = "0x89ddff";
          white = "0xffffff";
        };
      };

      background_opacity = 1;

      live_config_reload = true;

      key_bindings = [
        {
          key = "Key0";
          mods = "Control";
          action = "ResetFontSize";
        }
        {
          key = "Equals";
          mods = "Control";
          action = "IncreaseFontSize";
        }
        {
          key = "Minus";
          mods = "Control";
          action = "DecreaseFontSize";
        }
      ];
    };
  };
}
