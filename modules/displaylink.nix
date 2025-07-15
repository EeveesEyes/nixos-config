{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    displaylink
  ];
  boot = {
    extraModulePackages = [ config.boot.kernelPackages.evdi ];
    initrd = {
      # List of modules that are always loaded by the initrd.
      kernelModules = [
        "evdi"
      ];
    };
  };
  environment.variables = {
    WLR_EVDI_RENDER_DEVICE = "/dev/dri/card2"; # displayLink render device: ls -l /dev/dri/by-path
  };
  # weekly trim
  services.fstrim.enable = true;
  services = {
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
      defaultSession = "sway";
    };
  };
  # Enable proprietary firmware
  hardware.enableAllFirmware = true;

  # nix-prefetch-url --name displaylink-610.zip https://www.synaptics.com/sites/default/files/exe_files/2024-10/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu6.1-EXE.zip
  # nix-prefetch-url --name displaylink-611.zip https://www.synaptics.com/sites/default/files/exe_files/2025-04/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu6.1.1-EXE.zip
  services.xserver = {
    enable = true;
    videoDrivers = [
      "displaylink"
      "modesetting"
    ];
  };

  # --- THIS IS THE CRUCIAL PART FOR ENABLING THE SERVICE ---
  systemd.services.displaylink-server = {
    enable = true;
    # Ensure it starts after udev has done its work
    requires = [ "systemd-udevd.service" ];
    after = [ "systemd-udevd.service" ];
    wantedBy = [ "multi-user.target" ]; # Start at boot
    # *** THIS IS THE CRITICAL 'serviceConfig' BLOCK ***
    serviceConfig = {
      Type = "simple"; # Or "forking" if it forks (simple is common for daemons)
      # The ExecStart path points to the DisplayLinkManager binary provided by the package
      ExecStart = "${pkgs.displaylink}/bin/DisplayLinkManager";
      # User and Group to run the service as (root is common for this type of daemon)
      User = "root";
      Group = "root";
      # Environment variables that the service itself might need
      Environment = [ "DISPLAY=:0" ]; # Might be needed in some cases, but generally not for this
      Restart = "on-failure";
      RestartSec = 5; # Wait 5 seconds before restarting
    };
  };

}

# debug
# sudo dmesg | grep -E 'udl|DisplayLink|\[drm\]|evdi'
# sudo journalctl -u dlm.service
