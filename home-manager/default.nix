{ config, pkgs, lib, ... }:

let
  home-manager = (import ../nix/sources.nix).home-manager;
  unstable = import <nixos-unstable> { };
  fontSize = hiDPI: if hiDPI then "FiraCode:size=14" else "FiraCode:size=8";
in
{
  imports = [
    "${home-manager}/nixos"
  ];


  home-manager.users.fleaz = { pkgs, ... }: {
    imports = [
      modules/neovim.nix
      modules/vscode.nix
      modules/direnv.nix
      modules/sway.nix
      modules/git.nix
      modules/gpg.nix
      modules/udiskie.nix
      modules/discord.nix
      modules/devenv.nix
    ] ++ lib.optionals (config.networking.hostName == "jimbo") [
      modules/kanshi.nix
      ../secrets/codemonauts.nix
    ] ++ lib.optionals (config.networking.hostName == "milhouse") [
      modules/kanshi.nix
    ];

    nixpkgs.overlays = [
      (import ../overlay/default.nix)
    ];

    home.stateVersion = "21.11";

    gtk = {
      enable = true;
      theme = {
        name = "Adwaita";
        package = pkgs.gnome3.adwaita-icon-theme;
      };
    };

    xdg = {
      enable = true;
    };

    services.gnome-keyring.enable = true;

    # e.g. for  vscode
    nixpkgs.config.allowUnfree = true;


    home.packages = with pkgs; [
      httpie
      wdisplays
      albert
      firefox
      evince
      chromium
      via
      nextcloud-client
      deluge
      gnupg
      gpicview
      hicolor-icon-theme
      cinnamon.nemo
      element-desktop
      signal-desktop
      nix-output-monitor
      samba

      dnsutils
      mtr
      tig
      ncdu
      fd
      silver-searcher
      thunderbird
      mosh
      mpv
      go
      python3
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
      fzf
      ncmpcpp
      acpi

      unstable.prusa-slicer
      htop
      xdg-utils
      moreutils
      insomnia
      mumble
      inkscape
      guvcview

      # for coc
      nodejs
      rnix-lsp

      # from my overlay
      studio-link

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
      pwgen
      mysql-client
    ] ++ lib.optionals (config.networking.hostName == "milhouse") [
      networkmanager
    ];


    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "fzf" ];
        theme = "kolo";
      };
      history = {
        share = false; # every terminal has it's own history
        size = 10000;
      };
      shellAliases = {
        "dl" = "ls -lhtr --color=always ~/Downloads | tail -n 10"; # Show the 10 newest Downloads
        "notes" = "vim ~/codemonauts/notes.md"; # Open my work notes
        "summer" = "ssh -i Nextcloud/Privat/id_door door@door.w17.io summer";
      };
    };

    programs.git = {
      enable = true;
      userName = "fleaz";
      userEmail = "mail@felixbreidenstein.de";
    };

    programs.waybar = {
      enable = true;
      settings = [{
        layer = "top";
        position = "bottom";
        height = 28;
        modules-left = [
          "sway/workspaces"
          "sway/window"
        ];
        modules-center = [
        ];
        modules-right = [
          "sway/mode"
          "disk"
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
              warning = 20;
              critical = 10;
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
              warning = 80;
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
              default = [ "" "" ];
            };
            on-click = "pavucontrol";
          };
          "sway/workspaces" = {
            all-outputs = false;
            disable-scroll = false;
            format = "{name}";
          };
          "temperature" = {
            format = " {temperatureC}°C";
            hwmon-path = "/sys/class/hwmon/hwmon3/temp1_input";
            critical-threshold = 75;
          };
          "disk" = {
            interval = 30;
            format = "{free} free";
            path = "/";
          };
        };
      }];
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

    # Enable blueman-applet when the machine has bluetooth enabled
    services.blueman-applet.enable = config.hardware.bluetooth.enable == true;

    programs.foot = {
      enable = true;
      settings = {
        main = {
          term = "xterm-256color";
          font = fontSize config.my.highDPI;
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
