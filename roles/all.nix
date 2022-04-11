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
    # ../modules/via.nix broken
    ../modules/virtualbox.nix
    #../secrets/remote-builder.nix
    ../users/fleaz.nix
  ];


  # Temporary hacks that don't deserve their own module

  networking.extraHosts =
    ''
      10.10.37.2 bart2.fleaz.me
    '';

}

