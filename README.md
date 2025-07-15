# nixos-configuration

The NixOS configuration for my workstations.

## Add required prefetch
```
nix-prefetch-url --name displaylink-610.zip https://www.synaptics.com/sites/default/files/exe_files/2024-10/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu6.1-EXE.zip
```

## Usage

Symlink `/etc/nixos/configuration.nix` to the corresponding
`machines/<hostname>/configuration.nix` entry and just keep using
*nixos-rebuild* like nothing happend.


## Todo

* ssh key management
** ssh client config
* vs code config
* dev environments
* (borg)backup 
* nix code completion
* config split server <> laptop
* kanji