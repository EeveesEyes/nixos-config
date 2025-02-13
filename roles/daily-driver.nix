{ pkgs, config, ... }:
let consoleFont = hiDPI: if hiDPI then "Lat2-Terminus16" else "Lat2-Terminus28";
in {
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

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [ vesktop displaylink ];
  environment.variables = {
    DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
    WLR_EVDI_RENDER_DEVICE = "/dev/dri/card1"; # displayLink render device ls -l /dev/dri/by-path
    WLR_DRM_NO_MODIFIERS = 1;
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
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

  networking.extraHosts = "";

  # bigger tty fonts
  #console.font =
  #  "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
  # services.xserver.dpi = 180;


  # nix-prefetch-url --name displaylink-600.zip https://www.synaptics.com/sites/default/files/exe_files/2024-05/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu6.0-EXE.zip
  nixpkgs.overlays = [
    (final: prev: {
      wlroots_0_18 = prev.wlroots_0_18.overrideAttrs
        (old: { # you may need to use 0_18
          patches = (old.patches or [ ]) ++ [
            (prev.fetchpatch {
              url =
                "https://gitlab.freedesktop.org/wlroots/wlroots/uploads/bd115aa120d20f2c99084951589abf9c/DisplayLink_v2.patch";
              hash = "sha256-vWQc2e8a5/YZaaHe+BxfAR/Ni8HOs2sPJ8Nt9pfxqiE=";
            })
          ];
        });
    })
  ];
  services.xserver = {
    enable = true;
    videoDrivers = [ "displaylink" "modesetting" ];
  };
  systemd.services.dlm.wantedBy = [ "multi-user.target" ];
}
