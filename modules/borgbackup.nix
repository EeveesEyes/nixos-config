{config,...}:{
  programs.ssh.knownHosts = {
    "borg.cased.de" = { publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOwKHZZiJ/GgDmAbO2VdGNJIcBQKnFQNXBBzyrsK+ZE0"; };
  };

  services.borgbackup.jobs = {
    home = {
      paths = "/home";
      exclude = [
        "/home/hagoromo/.cache"
        "/home/hagoromo/Downloads"
        "/home/hagoromo/VirtualBox VMs"
        "/home/hagoromo/repos"
        "/home/hagoromo/.config/Code"
        "/home/hagoromo/.config/Element"
        "/home/hagoromo/.config/Signal"
        "/home/hagoromo/.config/chromium"
        "/home/hagoromo/.config/discord"
        "/home/hagoromo/.thunderbird"
        "/home/hagoromo/.mozilla"
        "/home/hagoromo/.vscode"
        "/home/hagoromo/.local"
      ];
      extraCreateArgs = "--stats";
      repo = "fleaz@borg.cased.de:${config.networking.hostName}";
      environment = { BORG_RSH = "ssh -i /home/hagoromo/.ssh/id_borgbackup"; };
      encryption = {
        mode = "repokey-blake2";
        passCommand = "cat /etc/secrets/borgbackup.txt";
      };
      compression = "auto,zstd";
      startAt = "hourly";
      prune.keep = {
        daily = 30;
        monthly = 6;
      };
    };
  };
}
