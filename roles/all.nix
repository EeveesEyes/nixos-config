{pkgs, config, ...}:
let
  consoleFont = hiDPI : if hiDPI then "Lat2-Terminus16" else "Lat2-Terminus20";
in
{
  imports = [
    ../home-manager/default.nix

    ../modules/avahi.nix
    ../modules/cups.nix
    ../modules/docker.nix
    ../modules/earlyoom.nix
    ../modules/fonts.nix
    ../modules/opengl.nix
    ../modules/pam.nix
    ../modules/sound.nix
    ../modules/ssh.nix
    ../modules/steam.nix
    ../modules/via.nix
    ../modules/virtualbox.nix
    ../modules/borgbackup.nix
    ../modules/udisks2.nix
    ../modules/samba.nix
    ../modules/gc.nix

    ../secrets/remote-builder.nix
    ../users/fleaz.nix
    ../customOptions.nix
  ];

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Locale
  i18n.defaultLocale = "en_DK.UTF-8";

  # needed for Steam and VIA
  nixpkgs.config.allowUnfree = true;

  # GTK settings stuff for e.g. themes
  programs.dconf.enable = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [ vim wget curl git ];

  environment.variables = {
    EDITOR = "nvim";
    PATH = "$PATH:/home/fleaz/bin";
    XDG_SCREENSHOTS_DIR = "/home/fleaz/screenshots/";
    DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
  };

  console.font = consoleFont config.my.highDPI;

  # weekly trim
  services.fstrim.enable = true;


  networking.extraHosts = ''
  '';
}

