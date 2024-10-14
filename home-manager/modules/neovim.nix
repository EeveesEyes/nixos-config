{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    withPython3 = true;
    extraPackages = with pkgs; [
      nil
      nixfmt-rfc-style
      gopls
      pyright
      (python3.withPackages (ps: with ps; [
        black
        flake8
        pylint
        isort
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
      nvim-web-devicons

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

      # markdown
      vim-markdown
      tabular

      # lsp and completion
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer

      conflict-marker-vim

      #saltstack
      salt-vim

      # show marks
      vim-signature

      # Session management
      auto-session

      # zoom into windows
      zoomwintab-vim

      # Telescope
      plenary-nvim
      telescope-nvim

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
      set nowrap
      set viminfo='1000,f1

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

      " Don't use gopls from vim-go
      let g:go_gopls_enabled = 0

      " neoformat
      let g:neoformat_run_all_formatters = 1
      let g:neoformat_python_black = {
            \ 'exe': 'black',
            \ 'stdin': 1,
            \ 'args': ['-q', '-l 120', '-'],
            \ }
      let g:neoformat_enabled_python = ['black', 'isort']

      " Find files using Telescope
      nnoremap <leader>ff <cmd>Telescope find_files<cr>
      nnoremap <leader>fg <cmd>Telescope live_grep<cr>

      lua << EOF
        require'netrw'.setup{}
        require("auto-session").setup {
          auto_save_enabled = true;
          auto_restore_enabled = true;
        }
        require("bufferline").setup{}

        require('lspconfig').gopls.setup{}
        require('lspconfig').pyright.setup{}

        require('lspconfig').nil_ls.setup {
          autostart = true,
          capabilities = caps,
          cmd = { "nil" },
          settings = {
            ['nil'] = {
              testSetting = 42,
              formatting = {
                command = { "nixfmt-rfc-style" },
              },
            },
          },
        }

        vim.api.nvim_create_autocmd('LspAttach', {
          desc = 'LSP actions',
          callback = function()
            local bufmap = function(mode, lhs, rhs)
              local opts = {buffer = true}
              vim.keymap.set(mode, lhs, rhs, opts)
            end

            -- Displays hover information about the symbol under the cursor
            bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

            -- Jump to the definition
            bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

            -- Jump to declaration
            bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

            -- Lists all the implementations for the symbol under the cursor
            bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

            -- Jumps to the definition of the type symbol
            bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

            -- Lists all the references 
            bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

            -- Displays a function's signature information
            bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

            -- Renames all references to the symbol under the cursor
            bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

            -- Selects a code action available at the current cursor position
            bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
            bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

            -- Show diagnostics in a floating window
            bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

            -- Move to the previous diagnostic
            bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

            -- Move to the next diagnostic
            bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
          end
        })

        vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
        local cmp = require('cmp')
        local select_opts = {behavior = cmp.SelectBehavior.Select}
        cmp.setup({
          sources = {
            {name = 'path'},
            {name = 'nvim_lsp', keyword_length = 1},
            {name = 'buffer', keyword_length = 3},
            {name = 'luasnip', keyword_length = 2},
          },
          window = {
            documentation = cmp.config.window.bordered()
          },
          formatting = {
            fields = {'menu', 'abbr', 'kind'}
          },
          mapping = {
              ['<CR>'] = cmp.mapping.confirm({select = false}),
              ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
              ['<Down>'] = cmp.mapping.select_next_item(select_opts),

              ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
              ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

              ['<C-u>'] = cmp.mapping.scroll_docs(-4),
              ['<C-d>'] = cmp.mapping.scroll_docs(4),

              ['<C-e>'] = cmp.mapping.abort(),
              ['<C-y>'] = cmp.mapping.confirm({select = true}),
              ['<CR>'] = cmp.mapping.confirm({select = false}),
              ['<Tab>'] = cmp.mapping(function(fallback)
                local col = vim.fn.col('.') - 1

                if cmp.visible() then
                  cmp.select_next_item(select_opts)
                elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                  fallback()
                else
                  cmp.complete()
                end
              end, {'i', 's'}),
              ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item(select_opts)
                else
                  fallback()
                end
              end, {'i', 's'}),


          }
        })

      EOF
    '';
  };
}
