{ pkgs, ... }: {
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  environment.systemPackages = [
    pkgs.blueman
  ];

  # Enable blueman-applet when the machine has bluetooth enabled
  services.blueman.enable = true;
}
