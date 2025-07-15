#!/usr/bin/env bash

show_help() {
    echo "Usage: $0 [--format FORMAT] [--help] HOST"
    echo
    echo "Options:"
    echo "  --disko           Rollout disk configuration using disko. (default: false)"
    echo "  --help            Show this help message and exit."
}

DISKO=false

while [[ $# -gt 0 && "$1" == --* ]]; do
    case "$1" in
    --disko)
        DISKO=true
        shift 1
        ;;
    --help)
        show_help
        exit 0
        ;;
    *)
        echo "Unknown option: $1"
        show_help
        exit 1
        ;;
    esac
done

# Your script logic here, using $FORMAT if needed

# nix run github:nix-community/nixos-anywhere -- --generate-hardware-config nixos-generate-config ./machines/kaguya/hardware-configuration.nix --disk-encryption-keys /tmp/secret.key <(keepassxc-cli show -s -y 2:18194253 ~/Dropbox/Apps/Keepass2Android/kinoxticket16042016-543_yubi.kdbx /DigitalKrams/Crypto/kaguya_encrypt | grep Password | awk -F '[ -]*' 'NR==1{print $NF;exit}') --flake .#kaguya root@192.168.178.190

# rebuild without disko:
# nix run github:nix-community/nixos-anywhere -- --generate-hardware-config nixos-generate-config ./machines/kaguya/hardware-configuration.nix --disk-encryption-keys /tmp/secret.key /tmp/secret.key --disko mount --flake .#kaguya root@192.168.178.190

# reset root pw for ssh login:
# root@kaguya# nixos-enter --root / -c 'passwd root'

# Current issues:
## no network connection after booting
# echo "nameserver 8.8.8.8" > /etc/resolv.conf
# $(which sshd)
# dhcpcd

# Errors
# Failed to mount /data
# See systemctl status data.mount for details.
# Dependency failed for Local File Systems.
# Filesystem 'data/encrypted' cannot be mounted, unable to open the dataset

HOST="${1}"
if [[ -z "$HOST" ]]; then
    echo "Error: HOST is not set. Please provide a hostname."
    exit 1
else 
    echo "Using HOST: $HOST"
fi

# check if /tmp/secret.key exists else read from password store
if [[ ! -f /tmp/secret.key ]]; then
    echo $(keepassxc-cli show -s -y 2:18194253 ~/Dropbox/Apps/Keepass2Android/kinoxticket16042016-543_yubi.kdbx /DigitalKrams/Crypto/kaguya_encrypt | grep Password | awk -F '[ -]*' 'NR==1{print $NF;exit}') >/tmp/secret.key
    chmod 600 /tmp/secret.key
fi

# Create a temporary directory and the SSH host key
if [[ -d /tmp/kaguya_ssh ]]; then
    echo "Directory /tmp/kaguya_ssh already exists. Using existing directory."
else
    echo "Creating hostkeys at directory /tmp/kaguya_ssh."
    
    temp=$(mktemp -d)
    cleanup() {
        rm -rf "$temp"
    }
    echo "Temporary directory created at: $temp"
    # trap cleanup EXIT
    ln -s /tmp/kaguya_ssh "$temp"
    install -d -m755 "$temp/etc/secrets/initrd"
    ssh-keygen -t ed25519 -N "" -f "$temp/etc/secrets/initrd/ssh_host_ed25519_key"
    chmod 600 "$temp/etc/secrets/initrd/ssh_host_ed25519_key"
fi

if $DISKO; then
    nix run github:nix-community/nixos-anywhere -- \
        --flake .#kaguya \
        --disk-encryption-keys /tmp/secret.key /tmp/secret.key \
        --extra-files "$temp" \
        --disko-mode disko \
        root@$HOST
else
    nix run github:nix-community/nixos-anywhere -- \
        --flake .#kaguya \
        --disk-encryption-keys /tmp/secret.key /tmp/secret.key \
        --extra-files "$temp" \
        --disko-mode mount \
        root@$HOST

fi
