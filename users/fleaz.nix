{ pkgs, ... }: {
  users.users.fleaz = {
    isNormalUser = true;
    extraGroups = [
      "wheel"          # Enable ‘sudo’ for the user.
      "networkmanager" # Access to networkmanager
      "docker"         # Access to the "/run/docker.sock"
    ];
    shell = pkgs.zsh;
    hashedPassword = "$6$9dARC6e2RxgPC9f1$QfXpT71cXA7YiFhv75Nnq2OrbQ8xlHMzgrJdaBaETaAVHLX5j8QUAl71dxMlqD.CtTLxe566kL5Q6da7Kqnvp/";
  };
}
