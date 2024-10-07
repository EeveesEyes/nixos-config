{ pkgs, config, ... }: {
  imports = [
    ../modules/nextcloud.nix
    # nextcloud
    # home-assistant
  ];

  # boot.kernelParams = [ "ip=192.168.172.109::192.168.172.255:255.255.255.0:kaguya::kaguya" ];
  boot.kernelParams = [ "ip=dhcp" ];
  networking.firewall = {
    #   allowedTCPPorts = [ 3000 ];
  };

  networking.extraHosts = ''
  '';
}
