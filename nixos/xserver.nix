{ pkgs, inputs, ... }:

let
  myCustomLayout = pkgs.writeText "xkb-layout" ''
    clear Lock
    keysym Caps_Lock = Escape
    keysym Escape = grave asciitilde
    add Lock = Caps_Lock

    keycode 108 = Multi_key
  '';
in
{
  # Configure the virtual console keymap from the xserver keyboard settings
  console.useXkbConfig = true;

  environment.systemPackages = with pkgs; [ xorg.xmodmap xorg.xev ];

  services = {
    xserver = {
      enable = true;
      # Recommended for modesetting drivers
      useGlamor = true;

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };

      windowManager.awesome = {
        enable = true;
      };

      displayManager = {
        defaultSession = "none+awesome";
        sessionCommands = ''
          ${pkgs.xorg.xmodmap}/bin/xmodmap ${myCustomLayout}
        '';
      };

      # Enable libinput
      libinput = {
        enable = true;
        touchpad = {
          disableWhileTyping = true;
          naturalScrolling = true;
          tapping = true;
        };
        mouse = {
          accelProfile = "flat";
        };
      };
    };
  };

  # Configure special programs (i.e. hardware access)
  programs = {
    dconf.enable = true;
    light.enable = true;
  };
}
