{ pkgs, ... }: {
  users.users.fleaz = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager" # Access to networkmanager
    ];
    shell = pkgs.zsh;
  };
}
