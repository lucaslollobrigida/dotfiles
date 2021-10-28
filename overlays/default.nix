{ inputs, pkgs, system, ... }: {
  nixpkgs.overlays = [
    inputs.nubank.overlay
    inputs.neovim-nightly-overlay.overlay
    (final: prev: {
      unstable = import inputs.unstable {
        inherit system;
        config = prev.config;
      };
    })
    (final: prev: {
      awesome = (prev.awesome.overrideAttrs (old: rec {
        src = prev.fetchFromGitHub {
          owner = "awesomeWM";
          repo = "awesome";
          rev = "8a81745d4d0466c0d4b346762a80e4f566c83461";
          sha256 = "sha256-5jg2X4u42yExa8sZaMhjbBA5HuQijWOn1QO87WwyPQw=";
        };
        GI_TYPELIB_PATH = "${prev.playerctl}/lib/girepository-1.0:"
          + "${prev.upower}/lib/girepository-1.0:" + old.GI_TYPELIB_PATH;
      })).override {
        stdenv = prev.clangStdenv;
        luaPackages = prev.lua52Packages;
        gtk3Support = true;
      };
    })
    (final: prev: {
      picom-jonaburg =
        prev.picom.overrideAttrs (old: { src = inputs.picom-jonaburg; });
    })
  ];
}
