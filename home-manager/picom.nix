{ config, lib, pkgs, ... }:

{
  services.picom = {
    enable = true;
    package = pkgs.picom-jonaburg;
  };

  xdg.configFile."picom.conf" = {
    source = ../conf/picom/picom.conf;
  };
}
