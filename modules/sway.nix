{
  # enable sway, so we have a swaylock pam config
  programs.sway.enable = true;
  programs.sway.package = null;

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

