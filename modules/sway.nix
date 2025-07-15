{ pkgs, nixpkgs-unfree, ... }: {
  environment.systemPackages = with pkgs; [ libinput-gestures wmctrl ];

  # enable sway, so we have a swaylock pam config
  programs.sway = {
    enable = true;
    package = nixpkgs-unfree.legacyPackages.${pkgs.system}.sway;
    extraOptions = [ "--verbose" "--debug" "--unsupported-gpu" ];
  };

  # autologin
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "sway --unsupported-gpu";
        user = "hagoromo";
      };
      initial_session = {
        command = "sway --unsupported-gpu";
        user = "hagoromo";
      };
    };
  };
}

