{ pkgs, ... }:
{
  home.file.".config/nvim/coc-settings.json".text = ''
    {
        "diagnostic.virtualText": true,
        "diagnostic.checkCurrentLine": false,
        "diagnostic.virtualTextCurrentLineOnly": false,
        "diagnostic.messageTarget": "",

        "suggest.noselect": true,

        "languageserver": {
          "nix": {
            "command": "nil",
            "filetypes": ["nix"],
            "rootPatterns": ["flake.nix"]
          }
        }
    }
    '';

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

      " COC

      " Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
      " delays and poor user experience
      set updatetime=300

      " Use tab for trigger completion with characters ahead and navigate
      " NOTE: There's always complete item selected by default, you may want to enable
      " no select by `"suggest.noselect": true` in your configuration file
      " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
      " other plugin before putting this into your config
      inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1) :
            \ CheckBackspace() ? "\<Tab>" :
            \ coc#refresh()
      inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

      " Make <CR> to accept selected completion item or notify coc.nvim to format
      " <C-g>u breaks current undo, please make your own choice
      inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                    \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

      function! CheckBackspace() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
      endfunction

      " Use <c-space> to trigger completion
      if has('nvim')
        inoremap <silent><expr> <c-space> coc#refresh()
      else
        inoremap <silent><expr> <c-@> coc#refresh()
      endif

      " Use `[g` and `]g` to navigate diagnostics
      " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
      nmap <silent> [g <Plug>(coc-diagnostic-prev)
      nmap <silent> ]g <Plug>(coc-diagnostic-next)

      " GoTo code navigation
      nmap <silent> gd <Plug>(coc-definition)
      nmap <silent> gy <Plug>(coc-type-definition)
      nmap <silent> gi <Plug>(coc-implementation)
      nmap <silent> gr <Plug>(coc-references)

      " Use K to show documentation in preview window
      nnoremap <silent> K :call ShowDocumentation()<CR>

      function! ShowDocumentation()
        if CocAction('hasProvider', 'hover')
          call CocActionAsync('doHover')
        else
          call feedkeys('K', 'in')
        endif
      endfunction

      " Highlight the symbol and its references when holding the cursor
      autocmd CursorHold * silent call CocActionAsync('highlight')

      " Symbol renaming
      nmap <leader>rn <Plug>(coc-rename)

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
