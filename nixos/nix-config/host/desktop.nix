{ config, pkgs, ... }:

{
  imports = [
    <home-manager/nixos>
    ../modules/settings.nix
    ../hardware-configuration.nix
    ../configuration.nix
    ../home/font.nix
    ../home/user.nix
  ];

  sound.enable = true;

  programs.dconf.enable = true;

  nixpkgs.config.allowUnfree = true;

  services.xserver = {
    enable = true;
    layout = "us";
    displayManager.defaultSession = "none+xmonad";
    desktopManager.xterm.enable = false;
  };

  users.users.${config.settings.username} = {
    isNormalUser = true;
    createHome = true;
    uid = 1000;
    shell = config.settings.shell;
    extraGroups = [ "wheel" "docker" "vboxusers" "networkmanager" ];
  };

  home-manager.users.${config.settings.username} = import ../home/home.nix;

  hardware = {
    # bluetooth.enable = true;

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    pulseaudio = {
      enable = true;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
    };
  };

  virtualisation = {
    # Enable Docker.
    docker.enable = true;

    # Enable VirtualBox.
    virtualbox.host.enable = true;
  };

  programs.java = {
    enable = true;
    package = pkgs.openjdk11;
  };

  # Enable Java anti-aliasing.
  environment.variables._JAVA_OPTIONS = "-Dswing.aatext=TRUE -Dawt.useSystemAAFontSettings=on";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];
  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.
  networking.useDHCP = false;
  networking.interfaces.enp1s0.useDHCP = true;

  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.firewall.allowedTCPPorts = [ 22 80 443 ];
  networking.firewall.allowPing = true;
  networking.firewall.enable = false;
}
