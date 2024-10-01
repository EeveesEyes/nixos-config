{ pkgs, config, ... }: {
  imports = [
    # nextcloud
    # home-assistant
    # 
  ];

  boot.initrd = {
    availableKernelModules = [ "r8169" ];
    network = {
      enable = true;
      udhcpc.enable = true;
      flushBeforeStage2 = true;
      ssh = {
        enable = true;
        port = 22;
        authorizedKeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAJVYO7GTEvh+tvV/ywlnv1a7F8btnl/CFN1hEcLrJ6O hagoromo@hiten" ];
        hostKeys = [ "/etc/secrets/initrd/ssh_host_ed25519_key" ];
      };
      postCommands = ''
        # Automatically ask for the password on SSH login
        echo 'cryptsetup-askpass || echo "Unlock was successful; exiting SSH session" && exit 1' >> /root/.profile
      '';
    };
  };
  boot.kernelParams = [ "ip=192.168.172.200::192.168.172.255:255.255.255.0:kaguya::none" ];


  networking.firewall = {
    #   allowedTCPPorts = [ 3000 ];
  };

  networking.extraHosts = ''
  '';
}
