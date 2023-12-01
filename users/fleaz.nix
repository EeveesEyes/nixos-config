{ pkgs, ... }: {
  programs.zsh.enable = true;

  users.users.fleaz = {
    isNormalUser = true;
    shell = pkgs.zsh;
    hashedPassword = "$6$9dARC6e2RxgPC9f1$QfXpT71cXA7YiFhv75Nnq2OrbQ8xlHMzgrJdaBaETaAVHLX5j8QUAl71dxMlqD.CtTLxe566kL5Q6da7Kqnvp/";

    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager" # Access to networkmanager
      "docker" # Access to the "/run/docker.sock"
      "dialout" # for serial access
    ];

    # Allow ssh between all my machines
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOOQB+LpTMWkmrx/ve1gxfzCM3CAsWpYkQ5QBRH1Vqf8 fleaz@cray"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOufg1IAWXQBbUPTc3W3vORxFc94/MbbaYzpimqI+M/J fleaz@jimbo"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKpdn6umACgFp2zucdvjHclYVZxUxWNZZvM7/h6HcJ+x fleaz@milhouse"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAO0UjGRIPO9zPwulEXVK8/pUIninT2H8gW2YlGlHwKH fleaz@smithers"
    ];
  };
}
