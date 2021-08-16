{ pkgs, ... }:
let
  # Mostly safe to block unless the service is doing something very strange
  safeHardeningFlags = {
    LockPersonality = true;
    NoNewPrivileges = true;
    PrivateTmp = true;
    RestrictAddressFamilies = "AF_UNIX AF_INET AF_INET6";
    RestrictNamespaces = true;
    RestrictRealtime = true;
    SystemCallArchitectures = "native";
  };
  strictHardeningFlags = safeHardeningFlags // {
    PrivateDevices = true;
    ProtectClock = true;
    ProtectControlGroups = true;
    ProtectHome = true;
    ProtectHostname = true;
    ProtectKernelLogs = true;
    ProtectKernelModules = true;
    ProtectKernelTunables = true;
    ProtectSystem = true;
  };
  restrictNetworkFlags = { RestrictAddressFamilies = "AF_UNIX"; };
  unrestrictNetworkFlags = { RestrictAddressFamilies = ""; };
in
{
  nix.trustedUsers = [ "root" "@wheel" ];

  # systemd-analyze --user security
  systemd.user.services = {
    opentabletdriver.serviceConfig = safeHardeningFlags // unrestrictNetworkFlags;
  };

  # systemd-analyze security
  systemd.services = {
    flood.serviceConfig = strictHardeningFlags // {
      ProtectHome = false;
    };
    plex.serviceConfig = safeHardeningFlags // unrestrictNetworkFlags // {
      RestrictNamespaces = false;
    };
    smartd.serviceConfig = strictHardeningFlags // {
      ProtectClock = false;
      PrivateDevices = false;
      PrivateNetwork = true;
    };
  };

  security = {
    rtkit.enable = true;
    # Increase file handler limit
    pam.loginLimits = [
      {
        domain = "*";
        type = "hard";
        item = "nofile";
        value = "1048576";
      }
    ];
  };

  # TODO: Enable usbguard after finding some way to easily manage it
  # services.usbguard = {
  #   enable = true;
  #   presentDevicePolicy = "keep";
  # };
}
