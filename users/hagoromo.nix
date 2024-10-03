{ pkgs, security, ... }: {
  programs.zsh.enable = true;

  users.users.hagoromo = {
    isNormalUser = true;
    shell = pkgs.zsh;

    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager" # Access to networkmanager
      "docker" # Access to the "/run/docker.sock"
      "dialout" # for serial access
    ];

    # Allow ssh between all my machines
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAJVYO7GTEvh+tvV/ywlnv1a7F8btnl/CFN1hEcLrJ6O hagoromo@kaguya"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAJVYO7GTEvh+tvV/ywlnv1a7F8btnl/CFN1hEcLrJ6O hagoromo@hiten"
    ];
  };
}
