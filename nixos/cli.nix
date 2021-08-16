{ config, pkgs, ... }:

{
  # CLI packages.
  environment.systemPackages = with pkgs; [
    aria2
    bc
    bind
    ffmpeg
    file
    glxinfo
    linuxPackages.cpupower
    lm_sensors
    lshw
    lsof
    mediainfo
    multitime
    netcat-gnu
    openssl
    p7zip
    pciutils
    powertop
    psmisc
    unrar
    unzip
    usbutils
  ];

  # Enable programs that need special configuration.
  programs = {
    iftop.enable = true;
    mtr.enable = true;
    zsh = {
      enable = true;
      promptInit = ''
        ${pkgs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin
      '';
    };
  };
}
