{ config, pkgs, lib, ... }:

let
  home-manager = (import ../nix/sources.nix).home-manager;
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
    ] ++ lib.optionals (config.networking.hostName == "jimbo") [
      modules/kanshi.nix
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

      swaylock
      swayidle
      wl-clipboard
      mako
      waybar
      sway-contrib.grimshot
      albert
      foot
      wofi

      prusa-slicer
      htop

    ] ++ lib.optionals (config.networking.hostName == "jimbo") [
      # Stuff only needed for work
      networkmanager
      networkmanager-openvpn
      packer
      rocketchat-desktop
      awscli
    ];


    programs.zsh = {
      enable = true;
      sessionVariables = {
        GOPATH = "/home/fleaz/workspace/go";
        EDITOR = "vim";
        XDG_SCREENSHOTS_DIR = "/home/fleaz/screenshots/";
        PATH = "$PATH:/home/fleaz/bin:/home/fleaz/workspace/go/bin";
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

    programs.waybar = { enable = true; };

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

    services.blueman-applet.enable = true;

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
