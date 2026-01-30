{ pkgs, ... }:
{
  security.pam.services."default".enableGnomeKeyring = true;

  programs.sway.extraSessionCommands = ''
    eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh);
    export SSH_AUTH_SOCK;
  '';

  services.gnome.gnome-keyring.enable = true;
  
  # get's autoenabled with gnome-keyring but we don't want it. 
  # Collision with noormal ssh-agent
  services.gnome.gcr-ssh-agent.enable = false;

  services.dbus.packages = [ pkgs.gnome-keyring pkgs.gcr ];
}
