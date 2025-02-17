{ ... }:

let
  home-manager = (import ../nix/sources.nix).home-manager;
in
{

  imports = [
    ../../home-manager/base.nix
    ../../home-manager/desktop.nix
  ];

  home.username = "hagoromo";
  home.homeDirectory = "/home/hagoromo";
  home.stateVersion = "21.11";
}
