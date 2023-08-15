{ config, pkgs, ... }:

{
  imports = [
    modules/neovim.nix
    modules/git.nix
  ];

  home.username = "felix";
  home.homeDirectory = "/home/felix";
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    sensu-go-cli
    kubectl
    krew
    tmux
    tmuxPlugins.gruvbox
    silver-searcher
    fd
    subversionClient
    tig
    freerdp

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
      "notes" = "vim ~/denic/notes.md"; # Open my work notes
      "buzzer" = "ssh -i Nextcloud/Privat/id_door door@door.w17.io buzzer";
      "k" = "kubectl";
      "windesk2" = "xfreerdp /u:felixb /w:1920 /h:1080 /v:w12243";
    };
    initExtra = ''
      export EDITOR="vim";
      export PATH="$PATH:$HOME/.krew/bin:$HOME/bin:$HOME/go/bin";
      source <(kubectl completion zsh)
    '';
  };

  programs.git = {
    enable = true;
    userName = "fleaz";
    userEmail = "mail@felixbreidenstein.de";
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

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/felix/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
