{ config, pkgs, lib, ... }:

let
  home-manager = (import ../nix/sources.nix).home-manager;
  unstable = import <nixos-unstable> { };
  base = import ./base.nix;
  desktop = import ./desktop.nix;
in
{
  imports = [
    "${home-manager}/nixos"
  ];


  home-manager.users.hagoromo = base ++ desktop



}