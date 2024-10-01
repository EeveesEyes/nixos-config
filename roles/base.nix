{ pkgs, config, ... }: {
  imports = [
    ../home-manager/base.nix

    ../customOptions.nix
    ../modules/docker.nix
    ../modules/fonts.nix
    ../modules/gc.nix
    ../modules/nixld.nix
    ../modules/opengl.nix
    ../modules/sound.nix
    ../modules/ssh.nix
    ../modules/udisks2.nix
  ];

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Locale
  i18n.defaultLocale = "en_DK.UTF-8";

  # needed for Steam and VIA
  nixpkgs.config.allowUnfree = true;

  # GTK settings stuff for e.g. themes
  programs.dconf.enable = true;

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [ vim wget curl git ];

  environment.variables = {
    EDITOR = "nvim";
    PATH = "$PATH:/home/hagoromo/bin";
    XDG_SCREENSHOTS_DIR = "/home/hagoromo/screenshots/";
  };

  # weekly trim
  services.fstrim.enable = true;

  # Look mum, I'm using all the new shiny stuff!
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable proprietary firmware
  hardware.enableAllFirmware = true;

  # TMP
  networking.firewall = {
    #   allowedTCPPorts = [ 3000 ];
  };

  networking.extraHosts = ''
  '';
}
