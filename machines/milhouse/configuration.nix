{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../roles/all.nix
    ../../modules/luks.nix
    ../../modules/grub.nix
    ];

  networking.hostName = "milhouse"; # Define your hostname.

  networking.useDHCP = false;
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  system.stateVersion = "21.11"; # Did you read the comment?

}

