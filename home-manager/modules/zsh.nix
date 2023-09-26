{
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
      "k" = "kubectl";
      "dl" = "ls -lhtr --color=always ~/Downloads | tail -n 10"; # Show the 10 newest Downloads
      "buzzer" = "ssh -i Nextcloud/Privat/id_door door@door.w17.io buzzer";
    };
    initExtra = ''
      export EDITOR="nvim";
      export PATH="$PATH:$HOME/.krew/bin:$HOME/bin:$HOME/go/bin";
      source <(kubectl completion zsh)
    '';
  };

}
