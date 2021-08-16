{ pkgs, ... }:

{
  # TODO: delete this package

  environment.systemPackages = with pkgs; [ acpi ];

  services = {
    # For battery status reporting
    upower.enable = true;

    # Only suspend on lid closed when laptop is disconnected
    logind = {
      lidSwitch = "suspend-then-hibernate";
      lidSwitchDocked = "ignore";
      lidSwitchExternalPower = "ignore";
    };

    # Reduce power consumption
    tlp.enable = true;
  };
}
