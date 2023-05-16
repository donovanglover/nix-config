{ pkgs, ... }:

{
  home-manager.sharedModules = [{
    programs.neovim = {
      enable = true;
      extraConfig = ''
        filetype plugin indent on
        set undofile
        set spell
        set number
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
        nnoremap <silent> <leader>a :NvimTreeToggle<CR>
        nnoremap <silent> <leader>f :Files<CR>
        nnoremap <silent> <leader>g :set hlsearch!<CR>
        nnoremap <silent> <leader>j :BufferPrevious<CR>
        nnoremap <silent> <leader>k :BufferNext<CR>
        nnoremap <silent> <leader>x :BufferClose<CR>
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
          plugin = barbar-nvim;
          type = "lua";
          config = ''
            vim.g.barbar_auto_setup = false
            require'barbar'.setup {
              auto_hide = true,
              sidebar_filetypes = {
                NvimTree = true,
              },
            }
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
          plugin = nvim-scrollbar;
          type = "lua";
          config = ''require("scrollbar").setup()'';
        }
        {
          plugin = nvim-base16;
          type = "lua";
          config = "vim.cmd('colorscheme base16-monokai')";
        }
        {
          plugin = lualine-nvim;
          type = "lua";
          config = "require('lualine').setup()";
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
      ];
    };
  }];
}
