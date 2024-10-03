{ config, pkgs, lib, ... }:

let
  home-manager = (import ../nix/sources.nix).home-manager;
  unstable = import <nixos-unstable> { };
in
{
  imports = [
    "${home-manager}/nixos"
  ];


  home-manager.users.hagoromo = { pkgs, ... }: {
    imports = [
      modules/discord.nix
      modules/foot.nix
      modules/neovim.nix
      modules/overlay.nix
      modules/sway.nix
      modules/tig.nix
      modules/vscode.nix
      modules/waybar.nix
      # ../secrets/ssh-config.nix
    ];

    home.packages = with pkgs; [
      httpie
      evince
      vivaldi
      via
      deluge
      hicolor-icon-theme
      cinnamon.nemo
      # element-desktop
      signal-desktop
      samba
      keepassxc
      spotify
      dropbox
      protonmail-bridge
      # darktable

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
      # sublime-music
      # ncmpcpp
      acpi
      adw-gtk3
      # unstable.joplin-desktop

      # unstable.prusa-slicer
      insomnia
      # mumble
      inkscape
      pwgen
      # kicad
      # picocom

      # kubernetes stuff
      # kubectl
      # krew
      # kubectx

    ];

    home.stateVersion = "21.11";

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
        };
      };
    };

    services.mako = {
      enable = true;
      groupBy = "app-name";
      defaultTimeout = 5000;
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

    # Enable blueman-applet when the machine has bluetooth enabled
    services.blueman-applet.enable = config.hardware.bluetooth.enable == true;

  };
}
