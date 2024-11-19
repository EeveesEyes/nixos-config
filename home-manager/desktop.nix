{ config, pkgs, ... }: {
  imports = [
    modules/foot.nix
    modules/neovim.nix
    modules/overlay.nix
    modules/tig.nix
    modules/vscode.nix
    modules/dropbox.nix
    modules/mako.nix
    modules/sway.nix
    modules/waybar.nix
    # modules/nix-colors.nix
    # ../secrets/ssh-config.nix
  ];

  home.packages = with pkgs; [
    httpie
    evince
    vivaldi
    via
    deluge
    hicolor-icon-theme
    nemo
    signal-desktop
    samba
    keepassxc
    spotify # doesnt work. ick anyways
    dropbox
    protonmail-bridge
    darktable

    # silver-searcher # source code searching tool
    thunderbird

    swaylock
    swayidle
    sway-audio-idle-inhibit
    brightnessctl
    wl-clipboard
    mako
    sway-contrib.grimshot
    foot
    wofi
    acpi
    adw-gtk3
    insomnia
    inkscape
    pwgen
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "adw-gtk3-dark";
    };
  };

  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "vivaldi-stable.desktop";
        "x-scheme-handler/http" = "vivaldi-stable.desktop";
        "x-scheme-handler/https" = "vivaldi-stable.desktop";
        "x-scheme-handler/about" = "vivaldi-stable.desktop";
        "x-scheme-handler/unknown" = "vivaldi-stable.desktop";
        "x-scheme-handler/mailto" = "userapp-Thunderbird-3CSQV2.desktop";
        "message/rfc822" = "userapp-Thunderbird-3CSQV2.desktop";
        "x-scheme-handler/mid" = "userapp-Thunderbird-3CSQV2.desktop";
      };
    };
  };

  services.gammastep = {
    enable = true;
    tray = true;
    latitude = "49.8";
    longitude = "8.6";
    temperature = {
      day = 5500;
      night = 3000;
    };

  };

}
