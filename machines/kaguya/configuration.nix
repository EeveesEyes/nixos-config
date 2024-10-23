# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# nix run github:nix-community/nixos-anywhere -- --generate-hardware-config nixos-generate-config ./machines/kaguya/hardware-configuration.nix --disk-encryption-keys /tmp/secret.key <(keepassxc-cli show -s -y 2:18194253 ~/Dropbox/Apps/Keepass2Android/kinoxticket16042016-543_yubi.kdbx /DigitalKrams/Crypto/kaguya_encrypt | grep Password | awk -F '[ -]*' 'NR==1{print $NF;exit}') --flake .#kaguya root@192.168.178.190

{ inputs, config, lib, pkgs, ... }: {
  imports =
    [
      ./disko-config.nix
      # ./hardware-configuration.nix
      ../../customOptions.nix
      ../../roles/base.nix
      # ../../roles/server.nix
      ../../users/hagoromo.nix
    ];

  # Look mum, I'm using all the new shiny stuff!
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  disko.devices.disk = {
    root.device = "/dev/sda";
    data1.device = "/dev/sdb";
    data2.device = "/dev/sdc";
    data3.device = "/dev/sdd";
    data4.device = "/dev/sde";
    data5.device = "/dev/sdf";
  };
  environment.systemPackages = with pkgs; [
    # Flakes clones its dependencies through the git command,
    # so git must be installed first
    git
    vim
    wget
    curl
    zfs-prune-snapshots
  ];

  boot = {
    loader =
      {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    # Newest kernels might not be supported by ZFS
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    kernelParams = [
      "nohibernate"
      "zfs.zfs_arc_max=17179869184"
    ];
    supportedFilesystems = [ "ntfs" "vfat" "zfs" ];
    zfs = {
      devNodes = "/dev/disk/by-id/";
      forceImportAll = true;
      requestEncryptionCredentials = true;
    };
  };
  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
  };

  networking = {
    hostName = "kaguya";
    hostId = "007f0200";
  };
  # Enable the LXQT Desktop Environment.
  services.xserver =
    {
      enable = true;
      displayManager.lightdm.enable = true;
      desktopManager.lxqt.enable = true;
    };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "yes"; # "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAJVYO7GTEvh+tvV/ywlnv1a7F8btnl/CFN1hEcLrJ6O hagoromo@hiten"
  ];


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
