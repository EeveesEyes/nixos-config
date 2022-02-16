{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [

      # Nice statusbar at the bottom
      vim-airline

      # Autoformatter for 'all' languages
      neoformat

      # Colorscheme
      vim-monokai

      # Fileexplorer in the sidebar
      nvim-tree-lua

      # Fancy icons for sidebar
      nvim-web-devicons

      # Bar at the top for all open buffers
      bufferline-nvim

      # git diff icons on the left sidebar
      vim-gitgutter
    ];
    extraConfig = ''
      set mouse=a
      set termguicolors
      set background=dark
      set nu
      colorscheme monokai
      lua << EOF
      require("bufferline").setup{}
      require("nvim-tree").setup{}
      EOF
    '';
  };
}
