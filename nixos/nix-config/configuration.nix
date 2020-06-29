{ config, pkgs, ... }:

{
  time.timeZone = "America/Sao_Paulo"; 
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    firefox
    git
    vim
    wget
    xorg.xmodmap
  ];

  services = {
    # blueman.enable = true;
    actkbd.enable = true;
    openssh.enable = true;
    printing.enable = true;
    earlyoom.enable = true;
    dbus.packages = [ pkgs.gcr ];
  };

  nix = {
     gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    # useSandbox = true;
    binaryCaches = [
      "https://cache.nixos.org/"
    ];
  };

  system.autoUpgrade = {
    enable = true;
    dates = "daily";
  }; 

  system.stateVersion = "20.03";
}
