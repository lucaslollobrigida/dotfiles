{ lib, pkgs, ... }: {
  home.packages = with pkgs; [
    brightnessctl
    multilockscreen
    mpc_cli
    mpd
    xsel
    xorg.xbacklight
  ];

  xsession = {
    enable = true;

    windowManager.awesome = {
      enable = true;
      noArgb = true;
      luaModules = with pkgs.luaPackages; [ luarocks ];
    };
  };

  systemd.user = {
    services = {
      setxkbmap.Service.ExecStart = lib.mkForce "${pkgs.coreutils}/bin/true";
    };
  };

  xdg.configFile."awesome" = {
    source = ../conf/awesome;
    recursive = true;
  };
}
