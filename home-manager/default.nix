{ config, pkgs, lib, ... }:

let
  home-manager = (import ../nix/sources.nix).home-manager;
  unstable = import <nixos-unstable> {};
in
{
  imports = [
    "${home-manager}/nixos"
  ];


  home-manager.users.fleaz = { pkgs, ... }: {
    imports = [
      modules/neovim.nix
      modules/vscode.nix
      modules/sway.nix
      modules/git.nix
      modules/gpg.nix
    ] ++ lib.optionals (config.networking.hostName == "jimbo") [
      modules/kanshi.nix
      ../secrets/codemonauts.nix
    ];

    gtk = {
      enable = true;
      theme.name = "Adwaita";
    };

    xdg = {
      enable = true;
    };

    services.gnome-keyring.enable = true;

    # e.g. for 1password
    nixpkgs.config.allowUnfree = true;


    home.packages = with pkgs; [
      httpie
      wdisplays
      albert
      firefox
      evince
      chromium
      discord
      gnome.gnome-keyring
      via
      nextcloud-client
      deluge
      gnupg
      gpicview
      docker-compose
      hicolor-icon-theme
      gnome3.adwaita-icon-theme
      cinnamon.nemo
      element-desktop
      signal-desktop
      nix-output-monitor
      gvfs
      samba

      dnsutils
      mtr
      tig
      ncdu
      fd
      fzf
      silver-searcher
      thunderbird-wayland
      mosh
      mpv
      poetry
      go
      python3Minimal
      pavucontrol
      playerctl
      jq
      psmisc
      zip
      nmap
      vnstat

      swaylock
      swayidle
      brightnessctl
      wl-clipboard
      mako
      sway-contrib.grimshot
      albert
      foot
      wofi
      unzip
      whois
      sublime-music

      unstable.prusa-slicer
      htop
      xdg-utils

      # for coc
      nodejs
      rnix-lsp

    ] ++ lib.optionals (config.networking.hostName == "jimbo") [
      networkmanager

      # Stuff only needed for work
      networkmanager-openvpn
      packer
      chefdk
      awscli
      shared-2fa
      igproxy-access
      sqlstrip
    ];


    programs.zsh = {
      enable = true;
      sessionVariables = {
        EDITOR = "vim";
        XDG_SCREENSHOTS_DIR = "/home/fleaz/screenshots/";
        PATH = "$PATH:/home/fleaz/bin";
        DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "fzf" ];
        theme = "robbyrussell";
      };
      history.size = 10000;
    };

    programs.git = {
      enable = true;
      userName = "fleaz";
      userEmail = "mail@felixbreidenstein.de";
    };

    programs.waybar = {
    enable = true;
    settings = [ {
      layer = "top";
      position = "bottom";
      height = 28;
      modules-left = [
        "sway/workspaces"
        "sway/mode"
        "sway/window"
      ];
      modules-center = [
      ];
      modules-right = [
        "pulseaudio"
        "network"
        "memory"
        "cpu"
        "temperature"
        "battery"
        "tray"
        "clock"
      ];
      modules = {
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = " {capacity}%";
          format-discharging = "{icon} {capacity}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };
        "cpu" = {
          format = "  {}";
        };
        "clock" = {
          format = "{:%H:%M}";
          tooltip = false;
        };
        "memory" = {
          interval = 5;
          format = "  {}%";
          tooltip-format = "{used:0.1f}/{total:0.1f} GB";
          states = {
            warning = 70;
            critical = 90;
	 };
	};
        "network" = {
          interface = "wl*";
          format-wifi = "  {essid}";
          format-icons = [
            ""
          ];
          tooltip-format-wifi = "{frequency} MHz, {signaldBm} dBm";
        };
        "pulseaudio" = {
          scroll-step = 1;
          format = "{icon}  {volume}%";
          format-bluetooth = "{icon} {volume}% ";
          format-muted = "";
          format-icons = {
            headphones = "";
            handsfree = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" ""];
          };
          on-click ="pavucontrol";
        };
        "sway/workspaces" = {
          all-outputs = false;
          disable-scroll = false;
          format = "{name}";
        };
        "temperature" = {
          format = " {temperatureC}°C";
        };
      };
    } ];
    style = builtins.readFile ./waybar.css;
  };


    programs.mako = {
      enable = true;
      groupBy = "app-name";
      defaultTimeout = 5000;
    };

    services.kanshi = {
      enable = true;

    };

    services.gammastep = {
      enable = true;
      tray = true;
      latitude = "49.8";
      longitude = "8.6";
      temperature = {
        day = 5500;
        night = 3300;
      };

    };

    services.blueman-applet.enable = config.networking.hostName == "jimbo";

    programs.foot = {
      enable = true;
      settings = {
        main = {
          term = "xterm-256color";
          font = "FiraCode:size=14";
        };
        scrollback = { lines = 100000; };
        colors = {
          alpha = "0.98";
          foreground = "B3B1AD";
          background = "0A0E14";
          regular0 = "01060E";
          regular1 = "EA6C73";
          regular2 = "91B362";
          regular3 = "F9AF4F";
          regular4 = "53BDFA";
          regular5 = "FAE994";
          regular6 = "90E1C6";
          regular7 = "C7C7C7";
          bright0 = "686868";
          bright1 = "F07178";
          bright2 = "C2D94C";
          bright3 = "FFB454";
          bright4 = "59C2FF";
          bright5 = "FFEE99";
          bright6 = "95E6CB";
          bright7 = "FFFFFF";
        };
      };
    };

  };
}
