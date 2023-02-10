{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    withPython3 = true;
    extraPackages = with pkgs; [
        nil
        nixpkgs-fmt
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
      papercolor-theme

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

      # markdown
      vim-markdown
      tabular

      vim-terraform
      vim-nix
    ];
    extraConfig = ''
      set nocompatible
      set mouse=a
      set termguicolors
      set background=dark
      set number
      set laststatus=2
      colorscheme PaperColor
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
      set textwidth=120

      " Autosave when focus is lost
      :au FocusLost * :wa

      " sync copy/paste buffer from vim with system buffer
      set clipboard^=unnamed

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

      " Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
      " delays and poor user experience
      set updatetime=300

      " Always show the signcolumn, otherwise it would shift the text each time
      " diagnostics appear/become resolved
      set signcolumn=yes

      " dont start with a fully folded document
      set nofoldenable

      " Remember cursor position
      autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif

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
