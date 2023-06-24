let
  secretsFile = "/root.key";
in
{
  boot.loader.grub.enableCryptodisk = true;

  # enable passing of keyfile between grub and initrd
  boot.initrd.luks.devices."cryptroot" = {
    fallbackToPassword = true;
    keyFile = secretsFile;
    allowDiscards = true; # Allow TRIM
  };

  # copy the secret into the additional initramfs. `null` means same path
  boot.initrd.secrets."${secretsFile}" = null;
}
