{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    coc = {
      enable = true;
    };
    withPython3 = true;
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

      # One languagepack to rule them all
      vim-polyglot

      # blockcomments
      tcomment_vim

      # Go plugin from fatih
      vim-go
    ];
    extraConfig = ''
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

      " Diasble polyglot for languages with their own plugin
      let g:polyglot_disabled = ["go"]

      " vim-go
      au FileType go nmap <leader>r <Plug>(go-run)
      au FileType go nmap <leader>b <Plug>(go-build)
      au FileType go nmap <leader>t <Plug>(go-test)
      let g:go_highlight_functions = 1
      let g:go_highlight_methods = 1
      let g:go_highlight_fields = 1
      let g:go_highlight_types = 1
      let g:go_highlight_operators = 1
      let g:go_highlight_build_constraints = 1

      lua << EOF
        require("bufferline").setup{}
        require("nvim-tree").setup{}
      EOF
    '';
  };
}
