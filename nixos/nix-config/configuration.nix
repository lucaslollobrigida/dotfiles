{ config, pkgs, ... }:

{
  imports = [ 
      ./x11.nix
      ./development.nix
      ./font.nix
      ./hardware-configuration.nix
    ];

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
    (import ./overlays/neovim.nix)
  ];

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
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp1s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  environment.systemPackages = with pkgs; [
    bat
    curl
    discord
    ((emacsPackagesGen emacsUnstable).emacsWithPackages (epkgs: [
      epkgs.emacs-libvterm
    ]))
    exa
    fd
    firefox
    fzf
    gimp
    gnupg
    haskellPackages.hoogle
    jq
    kitty
    llvm
    libnotify
    lxappearance
    msgpack
    (neovim.override ({
      vimAlias = true;
     })) 
    pavucontrol
    pinentry
    pinentry-gtk2
    ranger
    redshift
    ripgrep
    scrot
    slack
    spotify
    stow
    tldr
    tree
    unzip
    vim
    wget
    (pkgs.lib.overrideDerivation pkgs.st (attrs: {
      patches = attrs.patches ++ [
        ../.config/st/patches/st-alpha-0.8.2.diff
        ../.config/st/patches/st-xresources-20190105-3be4cf1.diff
        ../.config/st/patches/st-scrollback-0.8.2.diff

        # ../.config/st-patches/st-ligatures-alpha-20200430-0.8.3.diff
        # ../.config/st-patches/st-ligatures-alpha-scrollback-20200430-0.8.3.diff
        # ../.config/st-patches/st-ligatures-20200430-0.8.3.diff
        # ../.config/st-patches/st-font2-20190416-ba72400.diff
        # ../.config/st-patches/st-scrollback-mouse-0.8.2.diff
        # ../.config/st-patches/st-scrollback-20200419-72e3f6c.diff
      ];
      conf = builtins.readFile ../.config/st/config.h;
    }))
  ];

  services.actkbd = with pkgs; {
    enable = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gnome3";
  };

  services.blueman.enable = true;

  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [ 22 80 443 ];
  networking.firewall.allowPing = true;
  networking.firewall.enable = false;

  nixpkgs.config.allowUnfree = true;

  nix = {
    # useSandbox = true;
    trustedUsers = [ "root" "lollo" ];
    binaryCaches = [
      "https://cache.nixos.org/"
      "https://cachix.cachix.org"
      "https://all-hies.cachix.org"
      ];
    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
      "all-hies.cachix.org-1:JjrzAOEUsD9ZMt8fdFbzo3jNAyEWlPAwdVuHw4RD43k="
    ];
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;

  hardware = {
    bluetooth.enable = true;

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      s3tcSupport = true;
    };

    pulseaudio = {
      enable = true;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
    };
  };

  # Kill process consuming too much memory before it crawls the machine.
  services.earlyoom.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
    };
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
  };
  
  programs.dconf = {
    enable = true;
  };

  # Enable automatic GC.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Enable NixOS auto-upgrade.
  system.autoUpgrade = {
    enable = true;
    dates = "daily";
  }; 

  users.users.lollo = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "docker" "vboxusers" "networkmanager" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  system.stateVersion = "20.03";
}
