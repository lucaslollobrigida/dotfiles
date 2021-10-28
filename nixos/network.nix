{ pkgs, config, ... }:

{
  # Install laptop related packages
  environment.systemPackages = with pkgs; [ iw ];

  services.sshd.enable = true;

  # Enable programs that need special configuration
  programs = {
    # Enable NetworkManager applet
    nm-applet.enable = true;
  };

  # Make nm-applet restart in case of failure
  systemd.user.services.nm-applet = {
    serviceConfig = {
      RestartSec = 3;
      Restart = "on-failure";
    };
  };

  networking = {
    # Use Network Manager
    networkmanager = { enable = true; };

    wireless.userControlled.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };
}
