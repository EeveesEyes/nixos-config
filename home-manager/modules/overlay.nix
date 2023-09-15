{
  nixpkgs.overlays = [
    (import ../../overlay/default.nix)
  ];
}
