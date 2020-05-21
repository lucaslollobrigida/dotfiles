{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
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

  hardware.bluetooth.enable = true;

  environment.systemPackages = with pkgs; [
    clojure
    clojure-lsp
    cmake
    curl
    dmenu
    docker
    docker-compose
    fd
    firefox
    fzf
    gcc
    gitFull
    gnumake
    gnupg
    jq
    kitty
    kubectl
    leiningen
    llvm
    lxappearance
    minikube
    (neovim.override ({
      vimAlias = true;
     })) 
    nodejs
    oh-my-zsh
    pinentry
    pipenv
    python3Full
    ripgrep
    slack
    shellcheck
    stow
    tree
    unzip
    vim
    wget
    xclip
    xorg.xmodmap
    yarn
    zsh
  ];

  programs.java = {
    enable = true;
    package = pkgs.openjdk11;
  };

  # Enable Java anti-aliasing.
  environment.variables._JAVA_OPTIONS = "-Dswing.aatext=TRUE -Dawt.useSystemAAFontSettings=on";

  virtualisation = {
    # Enable Docker.
    docker.enable = true;

    # Enable VirtualBox.
    virtualbox.host.enable = true;
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

  nix.trustedUsers = [ "root" "lollo" ];
  nixpkgs.config.allowUnfree = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    desktopManager.xterm.enable = false;

    displayManager.defaultSession = "none+xmonad";

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = with pkgs; haskellPackages: [
        haskellPackages.xmonad-contrib
        haskellPackages.xmonad-extras
        haskellPackages.xmonad-contrib
        haskellPackages.xmonad
	dmenu
      ];
    };
    
    windowManager.i3 = {
      enable = false;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        dmenu i3status i3lock
      ];
    };

    displayManager.sessionCommands = with pkgs; lib.mkAfter
      ''
      xmodmap $HOME/.Xmodmap
      '';

  };

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
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
  
  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lollo = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "docker" "vboxusers" "networkmanager" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?
}
