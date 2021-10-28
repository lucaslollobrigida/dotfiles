{ config, pkgs, lib, ... }:

{
  theme = {
    fonts = {
      gui = {
        package = pkgs.roboto;
        name = "Roboto";
      };
    };

    # colors = builtins.fromJSON (builtins.readFile ./colors.json);
  };

  # Enable fonts in home.packages to be available to applications
  fonts.fontconfig.enable = true;

  # xdg.dataFile."wallpapers" = {
  #   source = ../conf/theme/wallpapers;
  #   recursive = true;
  # };

  xresources.properties = {
    "*background" = "#1D1D1D";
    "*foreground" = "#7b745b";
    "*cursorColor" = "ebdbb2";

    "*color0" = "#3B2B2C";
    "*color1" = "#A7623A";
    "*color2" = "#626C39";
    "*color3" = "#8C6B48";
    "*color4" = "#424949";
    "*color5" = "#5F4547";
    "*color6" = "#575A4B";
    "*color7" = "#9A8E6F";
    "*color8" = "#6f5541";
    "*color9" = "#A7623A";
    "*color10" = "#626C39";
    "*color11" = "#8C6B48";
    "*color12" = "#424949";
    "*color13" = "#5F4547";
    "*color14" = "#575A4B";
    "*color15" = "#9A8E6F";

    "Xft.dpi" = 108;
    "Xft.antialias" = true;
    "Xft.hinting" = true;
    "Xft.rgba" = "rgb";
    "Xft.autohint" = false;
    "Xft.hintstyle" = "hintslight";
    "Xft.lcdfilter" = "lcddefault";
  };

  home.packages = with pkgs;
    with config.theme.fonts; [
      dejavu_fonts
      font-awesome-ttf
      gnome3.gnome-themes-standard
      gui.package
      hack-font
      hicolor-icon-theme
      liberation_ttf
      material-design-icons
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      siji
    ];

  systemd.user.services = {
    xsettingsd = let
      mkKeyValue = (k: v: ''${k} "${v}"'');
      configFile = with lib.generators;
        with config.gtk;
        with config.xsession;
        toKeyValue { mkKeyValue = mkKeyValue; } {
          "Net/IconThemeName" = "${iconTheme.name}";
          "Net/ThemeName" = "${theme.name}";
          "Gtk/CursorThemeName" = "${pointerCursor.name}";
        };
    in {
      Unit = {
        Description =
          "Provides settings to X11 applications via the XSETTINGS specification";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Install = { WantedBy = [ "graphical-session.target" ]; };
      Service = {
        ExecStart = "${pkgs.kbdd}/bin/xsettingsd --config=${configFile}";
      };
    };
  };

  xsession.pointerCursor = {
    package = pkgs.gnome3.adwaita-icon-theme;
    name = "Adwaita";
    size = 32;
  };

  gtk = {
    enable = true;
    font = {
      package = pkgs.noto-fonts;
      name = "Noto Sans";
    };
    iconTheme = {
      package = pkgs.arc-icon-theme;
      name = "Arc";
    };
    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };
}
