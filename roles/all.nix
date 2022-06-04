{
  imports = [
    ../home-manager/default.nix
    ../modules/avahi.nix
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

  # needed for Steam and VIA
  nixpkgs.config.allowUnfree = true;

  # GTK settings stuff for e.g. themes
  programs.dconf.enable = true;

}

