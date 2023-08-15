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

## My Dell work laptop
My employer gave me a laptop with Ubuntu installed and is not that happy with the idea of me running NixOS on it.
Therefore I at least installed Home-Manager in standalone mode on it and created the `dell.nix` that can be used by
symlinking it to `~/.config/home-manager/home.nix`.
This way I at least get recent versions of tools with all of my personal config for e.g. Neovim.

