{ pkgs, config, ... }:
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
    #   ../modules/fwupd.nix
    #   ../modules/lix.nix
    ../modules/steam.nix
    #   ../secrets/remote-builder.nix
  ];

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [ vesktop ];
  environment.variables = {
    DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
  };
  virtualisation.vmware.host.enable = true;

  console.font = consoleFont config.my.highDPI;

  # weekly trim
  services.fstrim.enable = true;

  # Enable proprietary firmware
  hardware.enableAllFirmware = true;

  # TMP
  networking.firewall = {
    #   allowedTCPPorts = [ 3000 ];
  };

  networking.extraHosts = ''
  '';


  # bigger tty fonts
  #console.font =
  #  "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
  services.xserver.dpi = 180;
  environment.variables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };
}
