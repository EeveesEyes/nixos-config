# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  home-manager = (import ./nix/sources.nix).home-manager;
  secretsFile = "/root.key";
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../home-manager/default.nix
    ../../modules/earlyoom.nix
    ../../modules/fonts.nix
    ../../modules/opengl.nix
    ../../modules/remote-builder.nix
    ../../modules/sound.nix
    ../../modules/ssh.nix
    ../../users/fleaz.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.loader.systemd-boot.enable = false;
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "nodev";
    efiSupport = true;
    enableCryptodisk = true;
    configurationLimit = 5;
  };

  # enable passing of keyfile between grub and initrd
  boot.initrd.luks.devices."cryptroot" = {
    fallbackToPassword = true;
    keyFile = secretsFile;
  };
  # copy the secret into the additional initramfs. `null` means same path
  boot.initrd.secrets."${secretsFile}" = null;

  networking.hostName = "jimbo"; # Define your hostname.

  networking.extraHosts =
  ''
    10.32.4.64 cyberark.charite.de
    10.32.4.64 cya-pvwa.charite.de
    141.42.207.84 s-charitedigital.charite.de
    10.32.4.65 cya-psmp.charite.de

  '';

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  networking.useDHCP = false;
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

   services.avahi = {
  nssmdns = true;
  enable = true;
  ipv4 = true;
  ipv6 = true;
};

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };

  hardware.bluetooth.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.splix ];

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [ vim wget curl git 
];

  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  #virtualisation.podman = {
  #enable=true;
  #dockerCompat = true;
  #dockerSocket.enable = true;
  #};

  # i need docker because of the --link flag
  virtualisation.docker.enable = true;


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

