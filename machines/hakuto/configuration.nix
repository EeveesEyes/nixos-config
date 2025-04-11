# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, lib, pkgs, ... }: {
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../customOptions.nix
      ../../roles/base.nix
      ../../roles/daily-driver.nix
      ../../roles/laptop.nix
      ../../users/hagoromo.nix

      # import hardware specific settings
    ];
  # Hiten is a laptop
  my.isLaptop = true;
  my.hwModel = "framework-13-7040-amd";
  my.includeTLP = false;
  my.highDPI = true;

  # Look mum, I'm using all the new shiny stuff!
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  hardware.framework.amd-7040.preventWakeOnAC = true;

  environment.systemPackages = with pkgs; [
    # Flakes clones its dependencies through the git command,
    # so git must be installed first
    git
    vim
    wget
    curl
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "hakuto";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
