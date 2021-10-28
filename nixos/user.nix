{ config, lib, pkgs, ... }:
let inherit (config.user) username shell;
in {
  users.users.${username} = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "video" ];
    shell = shell;
  };
}
