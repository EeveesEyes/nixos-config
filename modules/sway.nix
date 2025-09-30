{ pkgs, nixpkgs-unfree, ... }: {
  environment.systemPackages = with pkgs; [ libinput-gestures wmctrl ];

  # enable sway, so we have a swaylock pam config
  programs.sway = {
    enable = true;
    package = null;
    extraOptions = [ "--verbose" "--debug" ];
  };

  # autologin
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "sway";
        user = "hagoromo";
      };
      initial_session = {
        command = "sway";
        user = "hagoromo";
      };
    };
  };
}

