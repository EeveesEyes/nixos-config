{ pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../roles/all.nix
    ../../modules/luks.nix
    ../../modules/grub.nix
  ];

  services.xserver.videoDrivers = [ "amdgpu" ];

  time.hardwareClockInLocalTime = true; #Be compatible with Windows Dualboot

  networking.useDHCP = false;
  networking.hostName = "cray"; # Define your hostname.
  networking.interfaces.enp4s0.useDHCP = true;
  networking.interfaces.enp4s0.wakeOnLan.enable = true;

  # Enable CUPS
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ splix ];

  system.stateVersion = "21.11"; # Did you read the comment?

}

