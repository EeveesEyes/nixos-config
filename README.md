# nixos-configuration

The NixOS configuration for my workstations.

## Add required prefetch
```
nix-prefetch-url --name displaylink-620.zip https://www.synaptics.com/sites/default/files/exe_files/2025-09/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu6.2-EXE.zip
```

## Usage

Symlink `/etc/nixos/configuration.nix` to the corresponding
`machines/<hostname>/configuration.nix` entry and just keep using
*nixos-rebuild* like nothing happend.


## Todo

* dev environments
* (borg)backup 
* nix code completion
* kanji