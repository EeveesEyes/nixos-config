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
      modules/devenv.nix
      modules/direnv.nix
      modules/git.nix
      modules/gpg.nix
      modules/manual.nix
      modules/udiskie.nix
      modules/zsh.nix
      # ../secrets/ssh-config.nix
    ];

    home.packages = with pkgs; [
      wdisplays
      firefox
      nextcloud-client
      gnupg
      gpicview
      nix-output-monitor

      dnsutils
      mtr
      tig
      ncdu
      fd
      ripgrep
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
      whois
      sipcalc
      strace
      usbutils
      pciutils
      veracrypt

      albert
      unzip
      whois
      fzf
      acpi
      htop
      xdg-utils
      moreutils
      guvcview
      gedit
      magic-wormhole
      wirelesstools
      xournal
      nix-tree
      nixpkgs-fmt
    ] ++ lib.optionals (config.my.isLaptop) [
      networkmanager
    ] ++ lib.optionals (config.my.hwModel == "t480") [
      throttled
    ];

    home.stateVersion = "21.11";

    gtk = {
      enable = true;
      gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
      gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    };

    services.gnome-keyring.enable = true;

    # e.g. for  vscode
    nixpkgs.config.allowUnfree = true;

    programs.git = {
      enable = true;
      userName = "EeveesEyes";
      userEmail = "a@kailus.dev";
    };
  };
}
