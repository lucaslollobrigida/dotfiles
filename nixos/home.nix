{ config, lib, pkgs, inputs, system, ... }:

with lib;
let
  inherit (config.user) username;
in
{
  imports = [ inputs.home.nixosModules.home-manager ];

  home-manager = {
    useUserPackages = true;
    users.${username} = ../home;
    extraSpecialArgs = {
      inherit inputs system;
      super = config;
    };
  };
}
