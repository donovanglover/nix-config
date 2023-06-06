{pkgs, ...}: {
  programs.neovim.enable = true;

  home-manager.sharedModules = [
    {
      programs.neovim = {
        enable = true;
        extraConfig = ''
          filetype plugin indent on
          set undofile
          set spell
          set number
          set linebreak
          set clipboard=unnamedplus
          set fileencoding=utf-8         " Ensure that we always save files as utf-8
          set fileencodings=utf-8,sjis   " Automatically open shiftjis files with their proper encoding
          set spelllang=en_us,cjk        " Don't show errors for CJK characters
          set noshowmode                 " Disable the --MODE-- text (enable if not using the status line)
          set mouse=a
          set ignorecase                 " By default use case-insensitive search (combine with smartcase)
          set smartcase                  " Make search case-sensitive when using capital letters
          set scrolloff=1                " The minimal number of rows to show when scrolling up/down
          set sidescrolloff=5            " The minimal number of columns to show when scrolling left/right
          set tabstop=4                  " Show a tab character as 4 spaces
          set softtabstop=0              " Edit soft tabs as if they're regular spaces
          set shiftwidth=4               " Make autoindent appear as 4 spaces

          set foldmethod=indent
          set foldlevelstart=99

          map <MiddleMouse> <Nop>
          imap <MiddleMouse> <Nop>
          map <2-MiddleMouse> <Nop>
          imap <2-MiddleMouse> <Nop>
          map <3-MiddleMouse> <Nop>
          imap <3-MiddleMouse> <Nop>
          map <4-MiddleMouse> <Nop>
          imap <4-MiddleMouse> <Nop>

          highlight Search ctermbg=240 ctermfg=255
          highlight IncSearch ctermbg=255 ctermfg=240

          let mapleader = ' '
          nnoremap <silent> <leader>e :set nu!<CR>
          nnoremap <silent> <leader>t :OverCommandLine<CR>%s/
          nnoremap <silent> <leader>a :NvimTreeFocus<CR>
          nnoremap <silent> <leader>f :Files<CR>
          nnoremap <silent> <leader>g :set hlsearch!<CR>
          nnoremap <silent> <leader>j :Buffers<CR>
          nnoremap <silent> <leader>l :Rg<CR>
          nnoremap <silent> <leader>; <C-w>w
          vnoremap <C-s> y:silent !notify-send -t 4000 "成果" "$(tango '<C-r>0')"<CR>:<Esc>

          autocmd BufNewFile,BufRead *.ecr    setlocal syntax=html
          autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
        '';
        plugins = with pkgs.vimPlugins; [
          {
            plugin = nvim-tree-lua;
            type = "lua";
            config = ''
              require("nvim-tree").setup()

              vim.api.nvim_create_autocmd("BufEnter", {
                nested = true,
                callback = function()
                  if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
                    vim.cmd "quit"
                  end
                end
              })
            '';
          }
          {
            plugin = indent-blankline-nvim;
            type = "lua";
            config = ''
              require("indent_blankline").setup()
            '';
          }
          {
            plugin = gitsigns-nvim;
            type = "lua";
            config = ''
              require('gitsigns').setup()
            '';
          }
          {
            plugin = nvim-web-devicons;
            type = "lua";
          }
          {
            plugin = nvim-lspconfig;
            type = "lua";
            config = "
            local lspconfig = require('lspconfig')
            lspconfig.nil_ls.setup {}
            lspconfig.rust_analyzer.setup {}
            lspconfig.marksman.setup {}
            lspconfig.gopls.setup {}
            lspconfig.lua_ls.setup {}
            lspconfig.clangd.setup {}
            lspconfig.texlab.setup {}
            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
            vim.api.nvim_create_autocmd('LspAttach', {
              group = vim.api.nvim_create_augroup('UserLspConfig', {}),
              callback = function(ev)
                local opts = { buffer = ev.buf }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
              end,
            })
          ";
          }
          {
            plugin = nvim-base16;
            type = "lua";
            config = "vim.cmd('colorscheme base16-monokai')";
          }
          {
            plugin = lualine-nvim;
            type = "lua";
            config = ''
              require('lualine').setup {
                sections = { lualine_c = {'%f'} }
              }
            '';
          }
          {
            plugin = git-blame-nvim;
            type = "lua";
          }
          {
            plugin = comment-nvim;
            type = "lua";
            config = ''require('Comment').setup()'';
          }
          {
            plugin = plenary-nvim;
            type = "lua";
          }
          {
            plugin = auto-save-nvim;
            type = "lua";
            config = ''require("auto-save").setup()'';
          }
          {
            plugin = vimtex;
            config = ''
              " Disable all keybinds so we can define our own
              let g:vimtex_mappings_enabled = 0
              let g:vimtex_imaps_enabled = 0
              let g:vimtex_view_method = 'zathura'
              let g:vimtex_compiler_latexmk = {'build_dir': '.tex'}

              " Set the normal keybinds
              nnoremap <localleader>f <plug>(vimtex-view)
              nnoremap <localleader>g <plug>(vimtex-compile)
              nnoremap <localleader>d <plug>(vimtex-env-delete)
              nnoremap <localleader>c <plug>(vimtex-env-change)
            '';
          }
          fzf-vim
          vim-caddyfile
          vim-graphql
          vim-pug
          vim-prisma
          vim-javascript
          vim-jsx-pretty
          vim-vue
          vim-over
          vim-endwise
          rust-vim
          neoformat
        ];
      };
    }
  ];
}
