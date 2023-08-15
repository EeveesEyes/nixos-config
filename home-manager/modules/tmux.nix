{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    escapeTime = 0;
    plugins = [
      pkgs.tmuxPlugins.gruvbox
    ];
    shell = "/home/felix/.nix-profile/bin/zsh";
    terminal = "xterm-256color";
    extraConfig = ''

      '';

  };
}
