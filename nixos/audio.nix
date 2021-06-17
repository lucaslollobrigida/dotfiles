{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    pamixer
    pavucontrol
    playerctl
    pulseaudio
    pulseeffects-pw
  ];

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };
}
