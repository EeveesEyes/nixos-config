{ config, pkgs, lib, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../roles/all.nix
    ../../roles/laptop.nix
    ../../modules/luks.nix
    ../../modules/grub.nix
    ../../modules/k40.nix

    # import hardware specific settings
    <nixos-hardware/dell/xps/13-9300>
  ];

  networking.hostName = "jimbo"; # Define your hostname.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  networking.useDHCP = false;
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  system.stateVersion = "21.11"; # Did you read the comment?

}

