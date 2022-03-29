{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    withPython3 = true;
    extraPackages = with pkgs; [
      (python3.withPackages (ps: with ps; [
        black
        flake8
      ]))
    ];
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [

      # Nice statusbar at the bottom
      vim-airline

      # Autoformatter for 'all' languages
      neoformat

      # Colorscheme
      gruvbox-nvim

      # Fileexplorer in the sidebar
      nvim-tree-lua

      # Fancy icons for sidebar
      nvim-web-devicons

      # Bar at the top for all open buffers
      bufferline-nvim

      # git diff icons on the left sidebar
      vim-gitgutter

      # blockcomments
      tcomment_vim

      # Coc language server support
      coc-nvim
      coc-go
      coc-python
    ];
    extraConfig = ''
      set nocompatible
      set mouse=a
      set termguicolors
      set background=dark
      set nu
      colorscheme gruvbox
      set hlsearch
      set tabstop=4
      set shiftwidth=4
      set softtabstop=4
      set expandtab
      set cursorline
      let mapleader = ","

      " Autosave when focus is lost
      :au FocusLost * :wa

      ""Hotkeys
      set pastetoggle=<F10>
      nnoremap <silent><cr> :nohlsearch<CR>
      inoremap jj <Esc>

      " Faster tab switching
      map <Tab> :bnext<cr>
      map <S-Tab> :bprevious<cr>

      " easier moving of code blocks
      set hidden
      vnoremap < <gv
      vnoremap > >gv

      " Permanent undo history
      set dir=~/.tmp/
      set backupdir=~/.tmp/bak
      if v:version >= 703
        set undodir=~/.tmp/
        set undofile
        set undolevels=100
        set undoreload=1000
      endif

      lua << EOF
        require("bufferline").setup{}
        require("nvim-tree").setup{}
      EOF
    '';
  };
}
