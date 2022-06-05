{pkgs, ...}:{
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

    ../secrets/remote-builder.nix

    ../users/fleaz.nix
  ];

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # needed for Steam and VIA
  nixpkgs.config.allowUnfree = true;

  # GTK settings stuff for e.g. themes
  programs.dconf.enable = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [ vim wget curl git ];
}

