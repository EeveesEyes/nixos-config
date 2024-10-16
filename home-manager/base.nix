{ pkgs, ... }: {
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
    veracrypt

    python3
    go

    dnsutils
    fd
    fzf
    gedit
    guvcview
    htop
    jq
    magic-wormhole
    moreutils
    mosh
    mpv
    mtr
    ncdu
    nix-tree
    nixpkgs-fmt
    nmap
    pavucontrol
    pciutils
    playerctl
    psmisc
    ripgrep
    sipcalc
    strace
    tig
    unzip
    usbutils
    vnstat
    whois
    wirelesstools
    xdg-utils
    xournal
    zip
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

  # e.g. for  veracrypt
  nixpkgs.config.allowUnfree = true;

  programs.git = {
    enable = true;
    userName = "EeveesEyes";
    userEmail = "a@kailus.dev";
  };
}
