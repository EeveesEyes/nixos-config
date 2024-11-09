{ pkgs, security, ... }: {
  programs.zsh.enable = true;

  users.users.hagoromo = {
    isNormalUser = true;
    shell = pkgs.zsh;
    hashedPassword = "$y$j9T$2UCdQ/G4btm27wWIInxQv.$fz5.4TG2d1XmRZxgbOI3BRDI74UYwPay9jYkqKLcDF5";

    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager" # Access to networkmanager
      "docker" # Access to the "/run/docker.sock"
      "dialout" # for serial access
      "input" # for touchpad access
    ];

    # Allow ssh between all my machines
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAJVYO7GTEvh+tvV/ywlnv1a7F8btnl/CFN1hEcLrJ6O hagoromo@kaguya"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAJVYO7GTEvh+tvV/ywlnv1a7F8btnl/CFN1hEcLrJ6O hagoromo@hiten"
    ];
  };

  systemd.user.services.add_ssh_keys = {
    script = ''
      eval `${pkgs.openssh}/bin/ssh-agent -s`
      ${pkgs.openssh}/bin/ssh-add $HOME/.ssh/id_ed25519
      ${pkgs.openssh}/bin/ssh-add $HOME/.ssh/github_id_ed25519
    '';
    wantedBy = [ "default.target" ];
  };
}
