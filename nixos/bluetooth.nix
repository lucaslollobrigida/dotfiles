{ pkgs, config, ... }:

{
  services = { blueman.enable = true; };

  hardware = { bluetooth.enable = true; };

  services.pipewire.media-session.config.bluez-monitor.rules = [
    {
      matches = [{ "device.name" = "~bluez_card.*"; }];
      actions = {
        "update-props" = {
          "bluez5.reconnect-profiles" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
          "bluez5.msbc-support" = true;
          "bluez5.sbc-xq-support" = true;
        };
      };
    }
    {
      matches = [
        # Matches all sources
        {
          "node.name" = "~bluez_input.*";
        }
        # Matches all outputs
        { "node.name" = "~bluez_output.*"; }
      ];
      actions = { "node.pause-on-idle" = false; };
    }
  ];
}
