{ config, lib, pkgs, ... }:

{
  xdg.configFile."eww" = {
    source = ../conf/eww;
    recursive = true;
  };
}
