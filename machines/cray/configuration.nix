{ pkgs, config, ... }:
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

  networking.useNetworkd = true;
  networking.useDHCP = false;
  networking.hostName = "cray"; # Define your hostname.
  networking.interfaces.enp4s0.useDHCP = true;
  networking.interfaces.enp4s0.wakeOnLan.enable = true;

  #boot.extraModulePackages = [ config.boot.kernelPackages.wireguard ];
  systemd.network = {
    enable = true;
    netdevs = {
      "10-wg-backbone" = {
        netdevConfig = {
          Kind = "wireguard";
          MTUBytes = "1300";
          Name = "wg-backbone";
        };
        extraConfig = ''
          [WireGuard]
          PrivateKeyFile=/etc/secrets/wireguard
          ListenPort=9918

          [WireGuardPeer]
          PublicKey=JjJrLv6ocRIgPGPz6TUexPj0eUSKPDEQFye4397nbwM=
          AllowedIPs=192.168.8.0/24
          Endpoint=marge.fleaz.me:50200
        '';
      };
    };
    networks = {
      # See also man systemd.network
      "40-wg0".extraConfig = ''
        [Match]
        Name=wg-backbone

        [Network]
        DHCP=no
        IPv6AcceptRA=false

        # IP addresses the client interface will have
        [Address]
        Address=192.168.8.13/24
      '';
    };
  };

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

