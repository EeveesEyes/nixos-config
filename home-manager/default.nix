{ config, pkgs, lib, ... }:

let
  home-manager = (import ../nix/sources.nix).home-manager;
  unstable = import <nixos-unstable> { };
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
      modules/overlay.nix
      modules/zsh.nix
      modules/foot.nix
    ] ++ lib.optionals (config.networking.hostName == "jimbo") [
      modules/kanshi.nix
    ] ++ lib.optionals (config.networking.hostName == "milhouse") [
      modules/kanshi.nix
    ];

    home.packages = with pkgs; [
      httpie
      wdisplays
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
      vnstat
      gnome.gedit
      pwgen

      # for coc
      nodejs
      rnix-lsp

      # kubernetes stuff
      kubectl
      krew
      kubectx

      # from my overlay
      studio-link
      #george-decker

    ] ++ lib.optionals (config.networking.hostName == "jimbo") [
      networkmanager
    ] ++ lib.optionals (config.networking.hostName == "milhouse") [
      networkmanager
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
        "buzzer" = "ssh -i Nextcloud/Privat/id_door door@door.w17.io buzzer";
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


    services.mako = {
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

  };
}
