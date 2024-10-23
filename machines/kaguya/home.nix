{ ... }:

let
  home-manager = (import ../nix/sources.nix).home-manager;
  unstable = import <nixos-unstable> { };
in
{

  imports = [
    ../../home-manager/base.nix
  ];

  home.username = "hagoromo";
  home.homeDirectory = "/home/hagoromo";
  home.stateVersion = "21.11";
}
