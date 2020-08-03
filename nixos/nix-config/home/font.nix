{ config, pkgs, ... }:

{
  imports = [
    ../modules/settings.nix
  ];

  fonts = {
    enableDefaultFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fontconfig.enable = true;

    fonts = with pkgs; [
      corefonts #unfree
      hack-font
      inconsolata
      font-awesome
      mononoki
      (nerdfonts.override {
        fonts = [
          "AnonymousPro"
          "FiraCode"
          "Inconsolata"
          "Hack"
          "Mononoki"
          "SourceCodePro"
        ];
      })
      source-code-pro
      xlsfonts
    ];

    fontconfig = {
      penultimate.enable = false;
      defaultFonts = {
        monospace = [ config.settings.fontName ];
      };
    };
  };
}
