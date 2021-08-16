{ super, lib, pkgs, inputs, ... }:
{
  imports = [
    ./alacritty.nix
    ./awesomewm.nix
    ./desktop.nix
    ./dev
    ./git.nix
    ./neovim.nix
    ./notification.nix
    ./picom.nix
    ./rofi.nix
    ./ssh.nix
    ./theme.nix
    ./tmux.nix
    ./zsh.nix
    ../overlays
    ../modules/theme.nix
    ../modules/user.nix
  ];

  nixpkgs.config = import ./nixpkgs-config.nix;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  programs.home-manager.enable = true;

  home.stateVersion = lib.mkForce "20.09";
}
