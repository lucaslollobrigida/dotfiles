{ config, lib, pkgs, ... }:

{
  services.picom = {
    enable = true;
    package = pkgs.picom-jonaburg;

    experimentalBackends = true;
    backend = "glx";
    vSync = true;

    activeOpacity = "1.0";
    inactiveOpacity = "1.0";
    menuOpacity = "1.0";
    opacityRule = [
      "100:name = 'Dunst'"
    ];

    # inactiveDim = "";

    blur = true;
    blurExclude = [
      "class_g = 'slop'"
      "_GTK_FRAME_EXTENTS@:c"
    ];

    fade = true;
    fadeDelta = 10;
    fadeExclude = [];
    fadeSteps = [ "0.015" "0.1" ];

    shadow = false;
    noDNDShadow = true;
    noDockShadow = true;
    shadowExclude = [];
    shadowOffsets = [ "-15" "-15" ];
    shadowOpacity = "0.75";

    extraOptions = ''
      detect-rounded-corners = true;
      detect-client-opacity = true;
      detect-transient = true;
      detect-client-leader = true;
      use-damage = true;
      mark-ovredir-focused = true;

      round-borders = 1;
      corner-radius = 12;

      rounded-corners-exclude = [
        "name = 'Notification area'",
        "name = 'Awesome drawin'",
        "class_g = 'Rofi'",
        "class_g = 'Polybar'",
        "class_g = 'Firefox'",
        "class_g = 'Thunderbird'"
      ];

      round-borders-rule = [
        "10:class_g = 'Alacritty'",
        "15:class_g = 'Signal'"
      ];

      focus-exclude = [
        "class_g = 'Cairo-clock'",
        "class_g = 'Bar'",
        "class_g = 'slop'"
      ];
    '';
  };
}
