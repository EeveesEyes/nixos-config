{ lib, ...}:{
  imports = [
    ../modules/bluetooth.nix
    ../modules/networkmanager.nix
    ../modules/tlp.nix
    ../modules/sus-then-hib.nix
  ];
}
