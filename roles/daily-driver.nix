{
  pkgs,
  config,
  lib,
  ...
}:
let
  consoleFont = hiDPI: if hiDPI then "Lat2-Terminus16" else "Lat2-Terminus28";
in
{
  imports = [
    # ../home-manager/default.nix

    ../modules/earlyoom.nix
    ../modules/samba.nix
    ../modules/sway.nix
    #   ../modules/avahi.nix
    #   ../modules/borgbackup.nix
    ../modules/cups.nix
    ../modules/fwupd.nix
    #   ../modules/lix.nix
    ../modules/steam.nix
    #   ../secrets/remote-builder.nix
  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "vivaldi"
      "spotify"
      "dropbox"
      "veracrypt"
    ];

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    vesktop
    displaylink
  ];

  environment.variables = {
    DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
    WLR_EVDI_RENDER_DEVICE = "/dev/dri/card1"; # displayLink render device ls -l /dev/dri/by-path
    WLR_DRM_NO_MODIFIERS = 1;
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };
  virtualisation.vmware.host.enable = false;

  console.font = consoleFont config.my.highDPI;

  # weekly trim
  services.fstrim.enable = true;

  # Enable proprietary firmware
  hardware.enableAllFirmware = true;

  # TMP
  networking.firewall = {
    allowedTCPPorts = [
      5173
      8123
      5005
      8080
      8000
    ];
  };

  networking.extraHosts = "";

  # bigger tty fonts
  #console.font =
  #  "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
  # services.xserver.dpi = 180;

  # nix-prefetch-url --name displaylink-610.zip https://www.synaptics.com/sites/default/files/exe_files/2024-10/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu6.1-EXE.zip
  services.xserver = {
    enable = true;
    videoDrivers = [
      "displaylink"
      "modesetting"
    ];
  };
  systemd.services.dlm.wantedBy = [ "multi-user.target" ];
}
