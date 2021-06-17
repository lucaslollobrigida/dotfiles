{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ alacritty ];

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
