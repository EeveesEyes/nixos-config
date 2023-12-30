{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../roles/all.nix
      ../../roles/laptop.nix
      ../../modules/k40.nix

      # import hardware specific settings
      <nixos-hardware/framework/13-inch/7040-amd>
    ];

  # disable the include of TLP because we get the fancy AMD one from nixos-hardwware
  my.includeTLP = false;

  # Don't wake from sleep if plugged into AC
  hardware.framework.amd-7040.preventWakeOnAC = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "smithers";

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}

