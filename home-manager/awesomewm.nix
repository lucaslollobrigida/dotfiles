{ lib, pkgs, ... }:
{
  xsession = {
    enable = true;

    windowManager.awesome = {
      enable = true;
      noArgb = true;
      luaModules = with pkgs.luaPackages; [
        luarocks
        luadbi-mysql
        # oocairo
      ];
    };
  };

  systemd.user = {
    services = {
      setxkbmap.Service.ExecStart = lib.mkForce "${pkgs.coreutils}/bin/true";
    };
  };
}
