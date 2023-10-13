{
  # enable sway, so we have a swaylock pam config
  programs.sway.enable = true;

  # autologin
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "sway";
        user = "fleaz";
      };
      initial_session = {
        command = "sway";
        user = "fleaz";
      };
    };
  };
}

