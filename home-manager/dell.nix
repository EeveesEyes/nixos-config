{ config
, pkgs
, ...
}:
{
  imports = [
    modules/neovim.nix
    modules/git.nix
    modules/tmux.nix

    ../secrets/denic.nix
  ];

  home.username = "felix";
  home.homeDirectory = "/home/felix";
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # e.g. for  obsidian
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    sensu-go-cli
    kubectl
    krew
    kubectx
    silver-searcher
    fd
    subversionClient
    tig
    freerdp
    obsidian

    # for coc
    nodejs
    rnix-lsp

    # for zsh-fzf plugin
    fzf
    firefox
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
      "buzzer" = "ssh -i Nextcloud/Privat/id_door door@door.w17.io buzzer";
      "k" = "kubectl";
    };
    initExtra = ''
      export EDITOR="nvim";
      export PATH="$PATH:$HOME/.krew/bin:$HOME/bin:$HOME/go/bin";
      source <(kubectl completion zsh)
    '';
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "FiraCode:size=10";
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

  home.file = { };
  home.sessionVariables = { };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
