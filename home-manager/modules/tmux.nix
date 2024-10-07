{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    escapeTime = 0;
    plugins = [
      pkgs.tmuxPlugins.gruvbox
    ];
    shell = "/home/hagoromo/.nix-profile/bin/zsh";
    terminal = "xterm-256color";
    extraConfig = ''
      # switch panes using Alt-hjkl without prefix
      bind -n M-h select-pane -L
      bind -n M-l select-pane -R
      bind -n M-k select-pane -U
      bind -n M-j select-pane -D

      '';

  };
}
