{
  config,
  pkgs,
  nixpkgs-unfree,
  lib,
  ...
}:
{

  ### NOTE ###
  # 25.05 + DisplayLink + sway does not work :(
  # Behavior:
  # - sway and dlm starts, but the displaylink monitor is not detected
  #

  environment.systemPackages = with pkgs; [
    nixpkgs-unfree.legacyPackages.${pkgs.system}.displaylink
  ];
  
  boot = {
    extraModulePackages = [ config.boot.kernelPackages.evdi ];
    initrd = {
      kernelModules = [
        "evdi"
      ];
    };
  };

  environment.variables = {
    WLR_EVDI_RENDER_DEVICE = "/dev/dri/card0"; # displayLink render device: ls -l /dev/dri/by-path
    # WLR_DRM_DEVICES = "/dev/dri/card0"; # this renders sway on a dlm monitor, but not two and is consuming a lot of resources
  };

  # Enable proprietary firmware
  hardware.enableAllFirmware = true;

  # nix-prefetch-url --name displaylink-610.zip https://www.synaptics.com/sites/default/files/exe_files/2024-10/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu6.1-EXE.zip
  # nix-prefetch-url --name displaylink-611.zip https://www.synaptics.com/sites/default/files/exe_files/2025-04/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu6.1.1-EXE.zip
  # nix-prefetch-url --name displaylink-620.zip https://www.synaptics.com/sites/default/files/exe_files/2025-09/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu6.2-EXE.zip
  services.xserver = {
    enable = true;
    videoDrivers = [
      "displaylink"
      "modesetting"
    ];
  };
  systemd.services.dlm = {
    wantedBy = [ "multi-user.target" ];
  };
  

  # Udev rules for DisplayLink devices
  # might fix dmsg > evdi evdi.1: [drm] Cannot find any crtc or sizes
  services.udev.extraRules = ''
    # DisplayLink USB devices
    SUBSYSTEM=="usb", ATTR{idVendor}=="17e9", MODE="0666"
    KERNEL=="card[0-9]*", SUBSYSTEM=="drm", ATTRS{vendor}=="0x17e9", TAG+="seat", TAG+="master-of-seat"
  '';
}

# debug
# sudo dmesg | grep -E 'udl|DisplayLink|\[drm\]|evdi'
# sudo journalctl -u dlm.service
