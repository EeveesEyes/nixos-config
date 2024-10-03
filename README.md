# nixos-configuration

The NixOS configuration for my workstations.

## Add required channel Channel
```
nix-channel --add https://channels.nixos.org/nixos-22.11 nixos
nix-channel --add https://channels.nixos.org/nixos-unstable nixos-unstable
nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
nix-channel --update -v
```

## Usage

Symlink `/etc/nixos/configuration.nix` to the corresponding
`machines/<hostname>/configuration.nix` entry and just keep using
*nixos-rebuild* like nothing happend.
