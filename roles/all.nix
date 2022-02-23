{
  imports = [
    ../home-manager/default.nix
    ../modules/avahi.nix
    ../modules/earlyoom.nix
    ../modules/fonts.nix
    ../modules/opengl.nix
    ../modules/remote-builder.nix
    ../modules/sound.nix
    ../modules/ssh.nix
    ../modules/docker.nix
    ../users/fleaz.nix
  ];


  # Temporary hacks that don't deserve their own module

  networking.extraHosts =
    ''
      10.10.37.136 bart2.fleaz.me
      10.10.37.145 homer.fleaz.me
    '';

}

