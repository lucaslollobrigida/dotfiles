{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brightnessctl
    haskellPackages.greenclip
    maim
    smartmontools
    xclip
  ];

  services = {
    smartd = {
      enable = true;
      notifications.x11.enable = true;
    };
    gnome.gnome-keyring.enable = true;
  };

  services = {
    # Kill process consuming too much memory before it crawls the machine
    earlyoom.enable = true;

    # Trim SSD weekly
    fstrim = {
      enable = true;
      interval = "weekly";
    };

    # Decrease journal size
    journald.extraConfig = ''
      SystemMaxUse=500M
    '';

    # Suspend when power key is pressed
    logind.extraConfig = ''
      HandlePowerKey=suspend-then-hibernate
    '';

    # Enable NTP
    timesyncd.enable = lib.mkDefault true;

    # Set I/O scheduler
    # mq-deadline is set for NVMe, since scheduler doesn't make much sense on it
    # bfq for SATA SSDs/HDDs
    udev.extraRules = ''
      # set scheduler for NVMe
      ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/scheduler}="mq-deadline"
      # set scheduler for SSD and eMMC
      ACTION=="add|change", KERNEL=="sd[a-z]|mmcblk[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="bfq"
      # set scheduler for rotating disks
      ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"
    '';
  };
}
