{ pkgs, ... }:

{
  stylix.targets.neovim.plugin = "base16-nvim";

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      nodePackages.typescript-language-server
      nodePackages."@astrojs/language-server"
      emmet-language-server
      markdown-oxide
      tailwindcss-language-server
      vscode-langservers-extracted
      rust-analyzer
      texlab
      nixd
      universal-ctags
      typos-lsp
    ];

    extraConfig = # vim
      ''
        filetype plugin indent on

        set undofile
        set spell
        set number
        set linebreak
        set clipboard=unnamedplus
        set fileencoding=utf-8
        set fileencodings=utf-8,sjis
        set spelllang=en_us,cjk
        set noshowmode
        set mouse=a
        set ignorecase
        set smartcase
        set scrolloff=1
        set sidescrolloff=5

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
        highlight Folded ctermbg=NONE guibg=NONE

        let mapleader = ' '

        nnoremap <silent> <leader>e :set nu!<CR>
        nnoremap <silent> <leader>o :GitBlameToggle<CR>
        nnoremap <silent> <leader>a :NvimTreeFocus<CR>
        nnoremap <silent> <leader>d :bp\|bd #<CR>
        nnoremap <silent> <leader>f :Files<CR>
        nnoremap <silent> <leader>g :set hlsearch!<CR>
        nnoremap <silent> <leader>j :Buffers<CR>
        nnoremap <silent> <leader>l :Rg<CR>
        nnoremap <silent> <leader>; :NvimTreeToggle<CR>
        nnoremap <silent> <leader>b :Vista!!<CR>

        autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
        autocmd VimEnter * silent! :cd `git rev-parse --show-toplevel`

        tnoremap <C-space> <C-\><C-n>
      '';

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = # lua
          ''
            require("nvim-tree").setup {
              update_focused_file = {
                enable = true
              }
            }

            vim.api.nvim_create_autocmd({"QuitPre"}, {
              callback = function()
                vim.cmd("NvimTreeClose")
              end
            })

            local function open_nvim_tree(data)
              local real_file = vim.fn.filereadable(data.file) == 1
              local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

              if not real_file and not no_name then
                return
              end

              require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
            end

            vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
          '';
      }
      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = # lua
          ''
            require("ibl").setup()
          '';
      }
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = # lua
          ''
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
        config = # lua
          ''
            require("scrollbar").setup()
          '';
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = # lua
          ''
            local lspconfig = require('lspconfig')
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            lspconfig.eslint.setup {
              capabilities = capabilities,
              on_attach = function(client, bufnr)
                vim.api.nvim_create_autocmd("BufWritePre", {
                  buffer = bufnr,
                  command = "EslintFixAll",
                })
              end
            }

            lspconfig.tailwindcss.setup {
              capabilities = capabilities,
              on_attach = function(client, bufnr)
                require("tailwindcss-colors").buf_attach(bufnr)
              end
            }

            lspconfig.nixd.setup {
              capabilities = capabilities,
              offset_encoding = 'utf-8'
            }

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

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
              vim.lsp.handlers.hover, { border = "single" }
            )

            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
              vim.lsp.handlers.signature_help, { border = "single" }
            )

            vim.diagnostic.config {
              float = { border = "single" }
            }
          '';
      }
      {
        plugin = nvim-cmp;
        type = "lua";
        config = # lua
          ''
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require('lspconfig')

            local servers = {
              'rust_analyzer',
              'markdown_oxide',
              'html',
              'texlab',
              'prismals',
              'jsonls',
              'emmet_language_server',
              'astro',
              'cssls',
              'ts_ls',
              'typos_lsp',
            }

            for _, lsp in ipairs(servers) do
              lspconfig[lsp].setup {
                capabilities = capabilities,
              }
            end

            local luasnip = require('luasnip')
            local cmp = require('cmp')

            cmp.setup {
              snippet = {
                expand = function(args)
                  luasnip.lsp_expand(args.body)
                end,
              },
              mapping = cmp.mapping.preset.insert({
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),

                ['<CR>'] = cmp.mapping.confirm {
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = true,
                },

                ['<Tab>'] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                  else
                    fallback()
                  end
                end, { 'i', 's' }),

                ['<S-Tab>'] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                    cmp.select_prev_item()
                  elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                  else
                    fallback()
                  end
                end, { 'i', 's' }),
              }),

              sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
              },
            }
          '';
      }
      cmp-nvim-lsp
      cmp_luasnip
      {
        plugin = luasnip;
        type = "lua";
        config = # lua
          ''
            require("luasnip.loaders.from_vscode").lazy_load()
          '';
      }
      friendly-snippets
      {
        plugin = lualine-nvim;
        type = "lua";
        config = # lua
          ''
            local theme = require("lualine.themes.base16")
            theme.normal.b.bg = nil
            theme.normal.c.bg = nil
            theme.replace.b.bg = nil
            theme.insert.b.bg = nil
            theme.visual.b.bg = nil
            theme.inactive.a.bg = nil
            theme.inactive.b.bg = nil
            theme.inactive.c.bg = nil

            require('lualine').setup {
              options = {
                theme = theme,
                disabled_filetypes = {'NvimTree', 'tagbar'}
              },
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
        config = # lua
          ''
            require('Comment').setup {
              pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
            }
          '';
      }
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = # lua
          ''
            require("nvim-autopairs").setup()
          '';
      }
      {
        plugin = auto-save-nvim;
        type = "lua";
        config = # lua
          ''
            require("auto-save").setup()
          '';
      }
      {
        plugin = vimtex;
        config = # vim
          ''
            let g:vimtex_mappings_enabled = 0
            let g:vimtex_imaps_enabled = 0
            let g:vimtex_view_method = 'zathura'
            let g:vimtex_compiler_latexmk = {'out_dir': '/tmp/vimtex'}

            nnoremap <localleader>f <plug>(vimtex-view)
            nnoremap <localleader>g <plug>(vimtex-compile)
            nnoremap <localleader>d <plug>(vimtex-env-delete)
            nnoremap <localleader>c <plug>(vimtex-env-change)
          '';
      }
      {
        plugin = nvim-ts-autotag;
        type = "lua";
        config = # lua
          ''
            require('nvim-ts-autotag').setup()
          '';
      }
      {
        plugin = nvim-surround;
        type = "lua";
        config = # lua
          ''
            require('nvim-surround').setup()
          '';
      }
      {
        plugin = tailwindcss-colors-nvim;
        type = "lua";
        config = # lua
          ''
            require('tailwindcss-colors').setup()
          '';
      }
      {
        plugin = nvim-ts-context-commentstring;
        type = "lua";
        config = # lua
          ''
            require('ts_context_commentstring').setup {
              enable_autocmd = false,
            }
          '';
      }
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = # lua
          ''
            require('nvim-treesitter.configs').setup {
              highlight = {
                enable = true,
                disable = function(lang)
                  return lang ~= "javascript"
                    and lang ~= "tsx"
                    and lang ~= "typescript"
                    and lang ~= "astro"
                    and lang ~= "css"
                    and lang ~= "glsl"
                    and lang ~= "nix"
                    and lang ~= "prisma"
                    and lang ~= "markdown"
                end,
                additional_vim_regex_highlighting = true,
              },
            }
          '';
      }
      {
        plugin = vista-vim;
        config = # vim
          ''
            let g:vista_default_executive = 'nvim_lsp'
            let g:vista_executive_for = {
              \ 'rust': 'ctags',
              \ }

            autocmd QuitPre * silent! :Vista!
          '';
      }
      fzf-vim
      vim-graphql
      vim-javascript
      vim-jsx-pretty
      rust-vim
      neoformat
      vim-nix
      tagbar
      rainbow-delimiters-nvim
    ];
  };
}
