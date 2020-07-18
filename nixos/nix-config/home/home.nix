{ config, pkgs, ... }:

{
  imports = [
    ../modules/settings.nix
    ./dev.nix
    ./git.nix
    ./shell.nix
    ./tmux.nix
    ./user.nix
    ./xserver.nix
  ];

  nixpkgs.overlays = [
    # (import (builtins.fetchTarball {
    #   url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    # }))
    # (import ./pkgs/neovim.nix)
    (import ../overlays/st.nix)
  ];

  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    curl
    exa
    fd
    feh
    gimp
    haskellPackages.xmobar
    hexchat
    htop
    ranger
    redshift
    ripgrep
    slack
    spaceship-prompt
    spotify
    st
    stow
    unzip
    tldr
    xclip
  ];

  home.sessionVariables = {
    BROWSER = "firefox";
    EDITOR = "nvim";
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

  programs.home-manager = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "${pkgs.ripgrep}/bin/rg --files";
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
  };

  programs.rofi = {
    enable = true;
    # package = pkgs.rofi.override { plugins = [ pkgs.rofi-emoji ]; };
    theme = "Pop-Dark";
    borderWidth = 0;
    font = "${config.settings.fontName} ${toString config.settings.fontSize}";
    lines = 8;
    extraConfig = ''
      matching: "fuzzy";
      sort: true;
      sorting-method: "fzf";
      case-sensitive: false;

      modi: "window,run,ssh";
      drun-display-format: "{name} [<span weight='light' size='small'>({generic})</span>]";

      kb-screenshot: "Alt+S";
      kb-cancel: "Escape,Super_R+x";
    '';
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        alignment = "center";
        bounce_freq = 0;
        browser = "firefox -new-tab#9C71C7";
        corner_radius = 0;
        dmenu = "rofi -dmenu -p dunst:";
        follow = "none";
        font = "Terminus 14";
        format = "<b>%s</b>\n%b";
        frame_color = "#9C71C7";
        frame_width = 8;
        geometry = "0x20-10+30";
        history_length = 20;
        horizontal_padding = 16;
        icon_position = "right";
        idle_threshold = 120;
        ignore_newline = "no";
        indicate_hidden = "yes";
        line_height = 0;
        markup = "full";
        max_icon_size = 64;
        monitor = 0;
        padding = 20;
        separator_color = "auto";
        separator_height = 4;
        show_age_threshold = 60;
        show_indicators = "yes";
        shrink = "no";
        sort = "yes";
        startup_notification = false;
        sticky_history = "yes";
        transparency = 20;
        word_wrap = "yes";
      };

      urgency_low = {
        background = "#1E2029";
        foreground = "#bbc2cf";
        timeout = 8;
      };

      urgency_normal = {
        background = "#1B161F";
        foreground = "#bbc2cf";
        timeout = 14;
      };

      urgency_critical = {
        background = "#cc6666";
        foreground = "#1E2029";
        timeout = 0;
      };
    };
  };

  services.redshift = {
    enable = true;
    tray = true;
    latitude = "-23.557734";
    longitude = "-46.666942";
  };

  services.gpg-agent = {
    defaultCacheTtl = 1800;
    enableSshSupport = true;
    pinentryFlavor = "gnome3";
  };
}
