{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "fzf" "kubectx" ];
      theme = "kolo";
    };
    history = {
      share = true; # history
      extended = true;
      size = 10000;
    };
    shellAliases = {
      "dl" = "ls -lhtr --color=always ~/Downloads | tail -n 10"; # Show the 10 newest Downloads
      "prnt" = "lp -o job-sheets=standard,none -d Samsung_M283x_Series_SEC30CDA7A56D6E $1"; # print file
    };
    initContent = ''
      autoload -U colors && colors

      function is_ssh(){
        if [ ! -z $SSH_CLIENT ]; then
          echo %{$fg[red]%}SSH-Session on $(hostname -s)%{$reset_color%}
        fi
      }
      RPS1='$(is_ssh) $(kubectx_prompt_info)'
      export EDITOR="nvim";
      export PATH="$PATH:$HOME/bin:$HOME/go/bin";
      eval "$(direnv hook zsh)"
    '';
  };

}
