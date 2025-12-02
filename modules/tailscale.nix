{
  services.tailscale = {
    enable = true;
    extraDaemonFlags = [ "--accept-routes" ];
  };
}
