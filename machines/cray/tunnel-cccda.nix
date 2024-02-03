{
  systemd.network = {
    enable = true;
    netdevs = {
      "10-wg-cccda" = {
        netdevConfig = {
          Kind = "wireguard";
          MTUBytes = "1300";
          Name = "wg-cccda";
        };
        extraConfig = ''
          [WireGuard]
          PrivateKeyFile=/etc/secrets/wireguard-cccda
          ListenPort=9919

          [WireGuardPeer]
          PublicKey=4/Ta8Ms2g5UNxjzSY+2khfH9YK45tUbnipH8Np9wGgk=
          AllowedIPs=192.168.204.0/24,192.168.201.0/24
          Endpoint=vpn.darmstadt.ccc.de:443
        '';
      };
    };
    networks = {
      "40-wg0-cccda".extraConfig = ''
        [Match]
        Name=wg-cccda

        [Network]
        DHCP=no
        IPv6AcceptRA=false

        [Address]
        Address=192.168.204.12/24
      '';
    };
  };

}
