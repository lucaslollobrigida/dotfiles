{ config, lib, pkgs, ... }:

{
  services.picom = {
    enable = true;
    package = pkgs.picom-jonaburg;

    experimentalBackends = true;
    backend = "glx";
    vSync = true;

    activeOpacity = "1.0";
    # inactiveOpacity = "1.0";
    menuOpacity = "1.0";
    opacityRule = [
      "100:name = 'Dunst'"
      "99:class_g = 'Sakura' && focused"
      "80:class_g = 'Sakura' && !focused"
      "100:class_g = 'St' && focused"
      "80:class_g = 'St' && !focused"
      "100:window_type = 'normal'"
      "95:window_type = 'dialog'"
      "95:window_type = 'popup_menu'"
      "99:window_type = 'notification'"
    ];

    # inactiveDim = "";

    blur = true;
    blurExclude = [
      "class_g = 'slop'"
      "_GTK_FRAME_EXTENTS@:c"
      "window_type = 'desktop'"
      "window_type = 'utility'"
      "window_type = 'notification'"
      "class_g = 'slop'"
      "class_g = 'Firefox' && argb"
      "class_g = 'firefox' && argb"
      "name = 'rofi - Search'"
      "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
      "_NET_WM_STATE@:32a = '_NET_WM_STATE_FULLSCREEN'"
    ];

    fade = true;
    fadeDelta = 3;
    fadeExclude = [];
    fadeSteps = [ "0.03" "0.03" ];

    shadow = true;
    noDNDShadow = true;
    noDockShadow = true;
    shadowExclude = [];
    # shadowOffsets = [ -12 -12 ];
    shadowOpacity = "0.80";

    extraOptions = ''
      shadow-radius = 16;
      inactive-opacity-override = false;

      detect-rounded-corners = true;
      detect-client-opacity = true;
      detect-transient = true;
      detect-client-leader = true;
      use-damage = true;
      mark-ovredir-focused = true;

      round-borders = 7;
      corner-radius = 7.0;

      blur-kern = "3x3box";
      blur-method = "dual_kawase";
      blur-strength = 3;

      rounded-corners-exclude = [
        # "name = 'Notification area'",
        # "name = 'Awesome drawin'",
        # "class_g = 'Rofi'",
        # "class_g = 'Polybar'",
        # "class_g = 'Firefox'",
        # "class_g = 'Thunderbird'"
      ];

      focus-exclude = [
        "class_g = 'Cairo-clock'",
        "class_g = 'Bar'",
        "class_g = 'slop'"
      ];
    '';
  };
}
