{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    # (nerdfonts.override {
    #   fonts = [
    #     "Mononoki"
    #     "SourceCodePro"
    #   ];
    # })
    # inconsolata-nerdfont
    xlsfonts
  ];

  fonts = {
    enableDefaultFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fontconfig.enable = true;
    fonts = with pkgs; [
      corefonts
      dina-font
      hack-font
      fira-code
      fira-code-symbols
      font-awesome
      liberation_ttf
      mononoki
      mplus-outline-fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      source-code-pro
      proggyfonts
    ];

    fontconfig = {
      penultimate.enable = false;
      defaultFonts = {
        monospace = [ "Inconsolata Nerd Font Complete Mono" ];
      };
    };
  };
}
