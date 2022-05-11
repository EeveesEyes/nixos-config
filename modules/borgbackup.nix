{config,...}:
{
  programs.ssh.knownHosts = {
    "borg.cysec.de" = { publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOwKHZZiJ/GgDmAbO2VdGNJIcBQKnFQNXBBzyrsK+ZE0"; };
  };

  services.borgbackup.jobs = {
    home = {
      paths = "/home";
      exclude = [
        "/home/fleaz/.cache"
        "/home/fleaz/Downloads"
        "/home/fleaz/VirtualBox VMs"
        "/home/fleaz/repos"
        "/home/fleaz/.config/Code"
        "/home/fleaz/.config/Element"
        "/home/fleaz/.config/Signal"
        "/home/fleaz/.config/chromium"
        "/home/fleaz/.config/discord"
        "/home/fleaz/.thunderbird"
        "/home/fleaz/.mozilla"
        "/home/fleaz/.vscode"
        "/home/fleaz/.local"
      ];
      extraCreateArgs = "--stats";
      repo = "fleaz@borg.cysec.de:${config.networking.hostName}";
      environment = { BORG_RSH = "ssh -i /home/fleaz/.ssh/id_borgbackup"; };
      encryption = {
        mode = "repokey-blake2";
        passCommand = "cat /etc/secrets/borgbackup.txt";
      };
      compression = "auto,zstd";
      startAt = "hourly";
    };
  };
}
