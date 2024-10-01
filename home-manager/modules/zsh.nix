{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "fzf" "kubectx" ];
      theme = "kolo";
    };
    history = {
      share = false; # every terminal has it's own history
      extended = true;
      size = 10000;
    };
    shellAliases = {
      # "k" = "kubectl";
      # "kx" = "kubectx";
      "dl" = "ls -lhtr --color=always ~/Downloads | tail -n 10"; # Show the 10 newest Downloads
      "buzzer" = "ssh -i Nextcloud/Privat/id_door door@door.cccda.de buzzer";
      "beep" = "paplay /usr/share/sounds/freedesktop/stereo/complete.oga"; # play "ding" for long running jobs
      "dig" = "dig +short";
    };
    initExtra = ''
      autoload -U colors && colors

      function is_ssh(){
        if [ ! -z $SSH_CLIENT ]; then
          echo %{$fg[red]%}SSH-Session on $(hostname -s)%{$reset_color%}
        fi
      }
      RPS1='$(is_ssh) $(kubectx_prompt_info)'
      export EDITOR="nvim";
      export PATH="$PATH:$HOME/.krew/bin:$HOME/bin:$HOME/go/bin";
      eval "$(direnv hook zsh)"
    '';
  };

}
