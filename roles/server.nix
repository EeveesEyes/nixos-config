{ pkgs, config, ... }:
{
  imports = [
    ../modules/nextcloud.nix
    # nextcloud
    # home-assistant
  ];

  # boot.kernelParams = [ "ip=192.168.172.109::192.168.172.255:255.255.255.0:kaguya::kaguya" ];
  boot.kernelParams = [ "ip=dhcp" ];
  networking.firewall = {
    # allowedTCPPorts = [ 3000 ];
    allowedTCPPorts = [ 8032 ];
  };

  networking.extraHosts = '''';

  services.homepage-dashboard = {
    enable = true;
    listenPort = 8032;
    #    Host validation failed. See logs for more details.
    allowedHosts = "kaguya:8032,localhost:8032,127.0.1:8032";

  };
}
