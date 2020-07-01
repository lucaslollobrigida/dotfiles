{ config, pkgs, ... }:

{
  xsession.enable = true;

  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    extraPackages = hpkgs: [
      hpkgs.xmonad-contrib
      hpkgs.xmonad-extras
    ];
  };

  services.picom = {
    enable = true;
    fade = false;
    shadow = false;
    backend = "glx";
    vSync = true;
  };

  home.file.".Xmodmap" = {
    text = ''
      clear Lock
      keysym Caps_Lock = Escape
      keysym Escape = grave asciitilde
      add Lock = Caps_Lock
    '';
  };

  home.file.".Xresources" = {
    text = ''
      xterm*faceName: ${config.settings.fontName}:pixelsize=${toString config.settings.fontSize}:antialias=true:hinting=true
      xterm*renderFont: true
      xterm*background: black
      xterm*foreground: lightgrey

      st.font: ${config.settings.fontName}:pixelsize=${toString config.settings.fontSize}:antialias=true:hinting=true
      st.alpha: 0.8

      !! Default Colorscheme

      ! black
      *.color0:       #101010
      *.color8:       #434758

      ! red
      *.color1:       #f07178
      *.color9:       #ff8b92

      ! green
      *.color2:       #c3e88d
      *.color10:      #ddffa7

      ! yellow
      *.color3:       #ffcb6b
      *.color11:      #ffe585

      ! blue
      *.color4:       #82aaff
      *.color12:      #9cc4ff

      ! magenta
      *.color5:       #c792ea
      *.color13:      #e1acff

      ! cyan
      *.color6:       #89ddff
      *.color14:      #a3f7ff

      ! white
      *.color7:       #d0d0d0
      *.color15:      #ffffff
    '';
  };
}
