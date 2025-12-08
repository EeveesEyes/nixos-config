{
  config,
  ...
}:
{
  programs.ssh.knownHosts = {
    "homelab.local" = {
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFG5ekx6GnxwOjF0Mjb/GuzmnsWHNFyi45On6ptf/UoH";
    };
  };

  services.borgbackup.jobs.home = name: {
    paths = "/home";
    exclude = [
      "/home/hagoromo/.cache"
      "/home/hagoromo/Downloads"
      "/home/hagoromo/repos"
      "/home/hagoromo/.config/Code"
      "/home/hagoromo/.config/Element"
      "/home/hagoromo/.config/Signal"
      "/home/hagoromo/.config/vivaldi"
      "/home/hagoromo/.config/discord"
      "/home/hagoromo/.thunderbird"
      "/home/hagoromo/.mozilla"
      "/home/hagoromo/.vscode"
      "/home/hagoromo/.local"
    ];
    extraCreateArgs = "--stats";
    repo = "hagoromo@homelab.local:/data/backups/${config.networking.hostName}";
    environment = {
      BORG_RSH = "ssh -i /home/hagoromo/.ssh/id_ed25519 -vvv -o RequestTTY=no";
    };
    encryption.mode = "none";
    # encryption = {
    #   mode = "repokey-blake2";
    #   passCommand = "cat /etc/secrets/borgbackup/borg-passphrase";
    # };
    compression = "auto,zstd";
    startAt = "hourly";
    prune.keep = {
      daily = 30;
      monthly = 6;
    };
  };
}
