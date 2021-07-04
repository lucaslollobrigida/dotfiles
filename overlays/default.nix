{ inputs, pkgs, system, ... }:
{
  nixpkgs.overlays = [
    inputs.nubank.overlay
    # inputs.neovim-nightly-overlay.overlay
    (
      final: prev: {
        unstable = import inputs.unstable {
          inherit system;
          config = prev.config;
        };
      }
    )
    (
      final: prev: {
        picom-jonaburg = prev.picom.overrideAttrs (
          old: {
            src = inputs.picom-jonaburg;
          }
        );
      }
    )
  ];
}
