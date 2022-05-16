# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ sources ? import ../../nix
, pkgs ? sources.pkgs { }
, lib
, ...
}:

let
  home-manager = (import ./nix/sources.nix).home-manager;
  secretsFile = "/root.key";
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../roles/all.nix
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

  services.xserver.videoDrivers = [ "amdgpu" ];

  # Set your time zone.
  time.timeZone = "Europe/Berlin";
  time.hardwareClockInLocalTime = true; #Be compatible with Windows


  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.hostName = "cray"; # Define your hostname.
  networking.interfaces.enp4s0.useDHCP = true;
  networking.interfaces.enp4s0.wakeOnLan.enable = true;

  # Enable CUPS
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ splix ];

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [ vim wget curl git ];


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

