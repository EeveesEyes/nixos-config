{ pkgs, osConfig, ... }:
let cfg = osConfig.my; in
{
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
    gthumb
    nix-output-monitor
    veracrypt
    
    python3
    go

    imagemagick
    dnsutils
    fd
    fzf
    gedit
    guvcview
    htop
    jq
    lsof
    unixtools.netstat
    magic-wormhole
    moreutils
    mosh
    mpv
    mtr
    ncdu
    nix-tree
    nixpkgs-fmt
    nixfmt
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
  ] ++ lib.optionals (cfg.isLaptop) [
    networkmanager
  ] ++ lib.optionals (cfg.hwModel == "t480") [
    throttled
  ];

  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  services.gnome-keyring.enable = true;

  programs.git = {
    enable = true;
    userName = "EeveesEyes";
    userEmail = "a@kailus.dev";
  };
}
