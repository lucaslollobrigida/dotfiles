{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    # TODO(lollo): break this and delete
    ../../nixos/temp.nix

    ../../nixos/system.nix

    ../../nixos/cli.nix

    ../../nixos/audio.nix
    ../../nixos/bluetooth.nix
    ../../nixos/dev.nix
    ../../nixos/fonts.nix
    ../../nixos/home.nix
    ../../nixos/locale.nix
    ../../nixos/network.nix
    ../../nixos/power_mgm.nix
    ../../nixos/user.nix
    ../../nixos/yubikey.nix
    ../../nixos/xserver.nix

    ../../cachix.nix
    ../../modules/user.nix

    inputs.hardware.nixosModules.common-gpu-nvidia-disable
    inputs.hardware.nixosModules.common-cpu-intel
  ];

  # Enable firmware-linux-nonfree
  hardware.enableRedistributableFirmware = true;

  nix = {
    gc = {
      automatic = true;
      dates = "3:15";
      options = "--delete-older-than 7d";
    };
    autoOptimiseStore = true;

    # Enable Flakes
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    registry.nixpkgs.flake = inputs.nixpkgs;
  };

  nixpkgs.config.allowUnfree = true;

  # networking.useDHCP = false;
  # networking.interfaces.wlp0s20f3.useDHCP = true;
  # networking.interfaces.enp56s0u1u2.useDHCP = true;

  hardware.nvidia.prime = {
    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
    intelBusId = "PCI:0:2:0";

    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
    nvidiaBusId = "PCI:1:0:0";
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices = {
    crypted = {
      device = "/dev/disk/by-uuid/b3768c5a-a811-4cd1-9bff-8d70f32a01ad";
      preLVM = true;
      allowDiscards = true;
    };
  };

  networking.hostName = "precision-nubank";

  system.stateVersion = "21.11";
}
