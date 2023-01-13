{ config, pkgs, lib, ... }:

let
  home-manager = (import ../nix/sources.nix).home-manager;
  unstable = import <nixos-unstable> {};
  fontSize = hiDPI : if hiDPI then 14 else 8;
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
    ] ++ lib.optionals (config.networking.hostName == "jimbo") [
      modules/kanshi.nix
      ../secrets/codemonauts.nix
    ] ++ lib.optionals (config.networking.hostName == "milhouse") [
      modules/kanshi.nix
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
      wofi
      unzip
      whois
      sublime-music
      fzf
      ncmpcpp
      acpi

      #unstable.prusa-slicer
      prusa-slicer
      htop
      xdg-utils
      moreutils
      insomnia
      mumble

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
      };
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
          hwmon-path = "/sys/class/hwmon/hwmon3/temp1_input";
          critical-threshold = 75;
        };
        "disk" = {
          interval= 30;
          format= "{free} free";
          path= "/";
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

    # Enable blueman-applet when the machine has bluetooth enabled
    services.blueman-applet.enable = config.hardware.bluetooth.enable == true;

    programs.kitty = {
      enable = true;
      font = {
        name = "Fira Code";
        size = fontSize config.my.highDPI;
      };
      settings = {
        disable_ligatures = "always";
        scrollback_lines = 50000;
        detect_urls = true;
        url_color = "#0087bd";
        url_style = "curly";
        copy_on_select = "clipboard";
        confirm_os_window_close = 0;
        background_opacity = "0.98";
        background = "#0A0E14";
      };
    };

  };
}
