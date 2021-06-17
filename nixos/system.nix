{ config, lib, pkgs, ... }:

with config.boot;
with lib;
{
  environment = {
    # To get zsh completion for system packages
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; [
      cachix
      curl
      git
      nss.tools
      vim
      zsh
    ];
  };

  boot = {
    kernel.sysctl = {
      # Enable Magic keys
      "kernel.sysrq" = 1;
      # Reduce swap preference
      "vm.swappiness" = 10;
    };
  };

  # Enable zram to have better memory management
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };
}
