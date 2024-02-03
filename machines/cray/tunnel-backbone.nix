{
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
          PrivateKeyFile=/etc/secrets/wireguard-backbone
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
      "40-wg0-backbone".extraConfig = ''
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

}
