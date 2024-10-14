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
      modules/tig.nix
      modules/vscode.nix
      modules/mako.nix
      modules/sway.nix
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
      signal-desktop
      samba
      keepassxc
      # spotify # doesnt work. ick anyways
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
      acpi
      adw-gtk3
      insomnia
      inkscape
      pwgen
    ];

    # e.g. for  vscode / spotify
    # nixpkgs.config.allowUnfree = true;
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

    # Enable blueman-applet when the machine has bluetooth enabled
    services.blueman-applet.enable = config.hardware.bluetooth.enable == true;

  };
}
