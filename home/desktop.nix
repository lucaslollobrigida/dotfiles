{ super, config, lib, pkgs, ... }:

let
  inherit (super.user) username;
in
{
  home.packages = with pkgs; [
    bitwarden
    brave
    desktop-file-utils
    discord
    evince
    feh
    guvcview
    gthumb
    pcmanfm
    spotify
    xautolock
    xorg.xdpyinfo
    xorg.xhost
    xorg.xkill
    xorg.xset
  ];

  programs.feh = {
    enable = true;
  };

  programs.firefox = {
    enable = true;
    profiles.${username} = {
      settings = {
        "gfx.webrender.all" = true;
        "browser.quitShortcut.disabled" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.ffvpx.enabled" = true;
        "media.navigator.mediadatadecoder_vpx_enabled" = true;
      };
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "org.gnome.Evince.desktop";
      "image/gif" = "org.gnome.gThumb.desktop";
      "image/jpeg" = "org.gnome.gThumb.desktop";
      "image/png" = "org.gnome.gThumb.desktop";
      "inode/directory" = "pcmanfm.desktop";
      "text/plain" = "nvim.desktop";
    };
  };
}
