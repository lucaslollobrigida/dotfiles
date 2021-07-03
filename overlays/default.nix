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
    (
      final: prev: {
        tint2-axarva = prev.tint2.overrideAttrs (
          old: {
            src = inputs.tint2-axarva;
            buildInputs = with pkgs; [
              cairo
              pango
              pcre
              glib
              imlib2
              gtk2
              xorg.libXinerama
              xorg.libXrender
              xorg.libXcomposite
              xorg.libXdamage
              xorg.libX11
              xorg.libXrandr
              librsvg
              xorg.libpthreadstubs
              xorg.libXdmcp
              libstartup_notification
            ];
          }
        );
      }
    )
  ];
}
