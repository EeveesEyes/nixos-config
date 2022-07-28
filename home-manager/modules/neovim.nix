{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    withPython3 = true;
    extraPackages = with pkgs; [
      (python3.withPackages (ps: with ps; [
        black
        flake8
        pylint
        jedi
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

      # Better support for netrw
      vim-vinegar

      # Bar at the top for all open buffers
      bufferline-nvim

      # git diff icons on the left sidebar
      vim-gitgutter

      # blockcomments
      tcomment_vim

      # Nix support
      vim-nix

      # Go plugin from fatih
      vim-go

      # Coc language server support
      coc-nvim
      coc-pyright
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
      set scrolloff=5
      let mapleader = ","
      set ignorecase
      set smartcase
      set colorcolumn=120

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
      EOF
    '';
  };
}
