{ config
, pkgs
, ...
}:
{
  imports = [
    modules/neovim.nix
    modules/git.nix
    modules/tmux.nix
    modules/foot.nix
    modules/overlay.nix
    modules/zsh.nix
    modules/manual.nix

    ../secrets/denic.nix
    ../customOptions.nix
  ];

  home.packages = with pkgs; [
    kubectl
    krew
    kubectx
    kubernetes-helm
    k9s
    silver-searcher
    fd
    subversionClient
    tig
    freerdp
    firefox
    bitwarden

    # for zsh-fzf plugin
    fzf


    # denic tooling from overlay
    gohome
  ];

  home.username = "felix";
  home.homeDirectory = "/home/felix";
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # e.g. for  obsidian
  nixpkgs.config.allowUnfree = true;

  home.file = { };
  home.sessionVariables = { };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  systemd.user.services.backup = {
    Unit = {
      Description = "Run a backup";
    };

    Service = {
      Type = "oneshot";
      ExecStart = "/home/felix/bin/backup.sh";
    };
  };

  systemd.user.timers.backup = {
    Unit = {
      Description = "Backup every 3h";
    };
    Timer = {
      OnBootSec = "3h";
      OnUnitActiveSec = "3h";
    };
    Install = {
      WantedBy= ["timers.target"];
    };
  };
}
