{ pkgs, config, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./tunnel-backbone.nix
    ./tunnel-cccda.nix
    ../../roles/all.nix
    ../../modules/luks.nix
    ../../modules/grub.nix
  ];

  services.xserver.videoDrivers = [ "amdgpu" ];

  time.hardwareClockInLocalTime = true; #Be compatible with Windows Dualboot

  networking.useNetworkd = true;
  networking.useDHCP = false;
  networking.hostName = "cray"; # Define your hostname.
  networking.interfaces.enp4s0.useDHCP = true;
  networking.interfaces.enp4s0.wakeOnLan.enable = true;

  # Enable CUPS
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ splix ];

  # AMD OpenGL Support
  hardware.opengl.extraPackages = with pkgs; [
    rocm-opencl-icd
    rocm-opencl-runtime
  ];

  system.stateVersion = "21.11"; # Did you read the comment?

}

