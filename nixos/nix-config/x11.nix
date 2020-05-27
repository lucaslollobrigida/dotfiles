{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dunst
    haskellPackages.xmobar
    nitrogen
    rofi
    # (rofi.override ({
    #   plugins = [ rofi-file-browser rofi-emoji rofi-systemd rofi-calc rofi-pass ];
    #  }))
    xclip
    xorg.xev
    xorg.xf86inputlibinput
    xorg.xf86inputkeyboard
    xorg.xmodmap
    xscreensaver

    # Delete
    dmenu
    polybarFull
  ];

  services.picom = {
    enable = true;
    fade = false;
    shadow = false;
    backend = "glx";
    vSync = true;
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    desktopManager.xterm.enable = false;

    displayManager.defaultSession = "none+xmonad";

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = with pkgs; haskellPackages: [
        haskellPackages.xmonad-contrib
        haskellPackages.xmonad-extras
        haskellPackages.xmonad
      ];
    };
    
    displayManager.sessionCommands = with pkgs; lib.mkAfter
      ''
      xrdb -merge ~/.Xresources &
      xmodmap ~/.Xmodmap
      '';
  };

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;
}
