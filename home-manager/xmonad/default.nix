{ config, lib, pkgs, ... }:

{
  xsession = {
    enable = true;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hp: [
        hp.xmonad-extras
        hp.xmonad-contrib
        hp.xmonad
      ];
      config = pkgs.writeText "xmonad.hs" (builtins.readFile ./config.hs);
    };
  };

  systemd.user = {
    services = {
      setxkbmap.Service.ExecStart = lib.mkForce "${pkgs.coreutils}/bin/true";
    };
  };

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      pulseSupport = true;
      iwSupport = true;
    };
    script = "polybar main &";

    settings = {
      "global/wm" = {
        margin.bottom = 0;
        margin.top = 0;
      };

      "bar/main" = {
        monitor = "DP-1";
        # monitor.strict = false;
        override.redirect = false;
        bottom = false;
        fixed.center = false;
        width = "100%";
        height = 30;
        offset = {
          x = "0%";
          y = "0%";
        };

        radius = {
          top = 0;
          bottom = 0;
        };

        line = {
          size = 2;
        };

        font = [
          "JetBrainsMono Nerd Font:style:bold:size=9;2"
          "Font Awesome 5 Free Solid:size=10;2"
        ];

        modules = {
          left = "workspaces";
          center = "title";
          right = "memory cpu audio wired-network wireless-network battery date";
        };

        wm.name = "xmonad";

        tray = {
          position = "right";
          detached = false;
          maxsize = 16;
        };
      };

      "module/ewmh" = {
        type = "internal/xworkspaces";
        pin.workspaces = false;
        icon = [
          "1"
          "2"
          "3"
          "4"
          "5"
          "6"
          "7"
          "8"
          "9"
        ];
      };
      "module/workspaces" = {};
      "module/title" = {};

      "module/colors" = {};
      "module/memory" = {
        type = "internal/memory";

        format = "<label>";
        format-prefix = " ";
        format-padding = 1;

        label = " %gb_used%";
      };
      "module/cpu" = {};
      "module/audio" = {
        type = "internal/pulseaudio";
        use.ui.max = false;

        format.volume = "<ramp-volume> <label-volume> ";
        format.volume-padding = 1;

        format.muted = "<label-muted>";
        format.muted-padding = 1;

        label.muted = " muted";
        ramp.volume = [
          ""
          ""
          ""
        ];

        click.right = "pavucontrol";
        click.middle = "pavucontrol";
      };

      "module/wired-network" = {
        type = "internal/network";
        interface = "enp56s0u1u2";

        label-connected = "  %local_ip%";
        label-disconnected = " Disconnected";
        label-connected-padding = 1;
        label-disconnected-padding = 1;
      };

      "module/wireless-network" = {
        type = "internal/network";
        interface = "wlp0s20f3";

        label-connected = "  %essid%";
        label-disconnected = "  Disconnected";
        label-connected-padding = 1;
        label-disconnected-padding = 1;
      };

      "module/battery" = {
        type = "internal/battery";
        battery = "BAT0";
        adapter = "AC";

        format.charging = "<label-charging>";
        format.charging-prefix = "  ";
        format.charging-background = "\${color.background}";
        format.charging-padding = 1;

        format.discharging = "<label-discharging>";
        format.discharging-prefix = "  ";
        format.discharging-background = "\${color.background}";
        format.discharging-padding = 1;

        format.full = "<label-full>";
        format.full-prefix = "  ";
        format.full-background = "\${color.background}";
        format.full-padding = 1;

        label.charging = "%percentage%%";
        label.discharging = "%percentage%%";
        label.full = "Full";

        animation.charging.framerate = 750;
      };

      "module/date" = {
        type = "internal/date";
        date = "%d/%m/%Y";
        time = "%H:%M";

        format = "<label>";
        format-prefix = " ";
        format-padding = 1;

        label = "%date% %time%";
      };
    };
  };
}
