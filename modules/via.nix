{ config, pkgs, lib, ... }: {
  # Load udev Rules for via
  services.udev.packages = [ pkgs.via ];
}
