{ pkgs, ... }: {
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [

      # Nice statusbar at the bottom
      vim-airline

      # Autoformatter for 'all' languages
      neoformat

      # Colorscheme
      vim-monokai
    ];
    settings = { ignorecase = true; };
    extraConfig = ''
      set mouse=a
    '';
  };
}
