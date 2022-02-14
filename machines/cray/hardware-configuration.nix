# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/60e06bf9-f4c4-4555-879b-23ade6599704";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/2e85528d-0086-4835-9fc7-0e7a847d90bd";

  fileSystems."/mnt/pool" = {
    device = "//BART/Pool/";
    fsType = "cifs";
    options =
      let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in
      [ "${automount_opts},credentials=/etc/nixos/smb-secrets" ];
  };
  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/274B-0F7C";
      fsType = "vfat";
    };

  swapDevices = [{
    device = "/dev/disk/by-partuuid/c5586d55-aca1-4771-9695-1232ba83d3f6";
    randomEncryption = true;

  }];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
