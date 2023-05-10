{ config, lib, nixpkgs, home-manager, ... }: {
  imports = [ home-manager.nixosModule ];
  home-manager.users.user = { pkgs, ... }: {
    programs.neovim = {
      enable = true;
      extraConfig = ''
        set undofile
        set spell
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
        /*
        {
          plugin = satellite-nvim;
          type = "lua";
          config = ''require('satellite').setup()'';
        }
        */
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
          plugin = autoclose-nvim;
          type = "lua";
          config = ''require("autoclose").setup()'';
        }
        {
          plugin = nvim-scrollbar;
          type = "lua";
          config = ''require("scrollbar").setup()'';
        }
        {
          plugin = nvim-base16;
          type = "lua";
          config = "vim.cmd('colorscheme base16-gruvbox-dark-soft')";
        }
        {
          plugin = lualine-nvim;
          type = "lua";
          config = "require('lualine').setup()";
        }
        {
          plugin = nvim-cursorline;
          type = "lua";
          config = ''
            require('nvim-cursorline').setup {
              cursorline = {
                enable = true,
                timeout = 1000,
                number = false,
              },
              cursorword = {
                enable = true,
                min_length = 3,
                hl = { underline = true },
              }
            }
          '';
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
          plugin = telescope-nvim;
          type = "lua";
        }
        {
          plugin = clipboard-image-nvim;
          type = "lua";
        }
        {
          plugin = nvim-colorizer-lua;
          type = "lua";
          # Note: supposed to add this line at the end?
          config = ''
            require 'colorizer'.setup()
          '';
        }
      ];
    };
    editorconfig = {
      enable = true;
      settings = {
        "*" = {
          charset = "utf-8";
          end_of_line = "lf";
          insert_final_newline = true;
          indent_size = 2;
          indent_style = "space";
          trim_trailing_whitespace = true;
        };
        "*.md" = { indent_style = "tab"; };
        "Makefile" = {
          indent_style = "tab";
          indent_size = 4;
        };
        "*.html" = {
          indent_style = "tab";
          indent_size = 4;
        };
        "*.go" = {
          indent_style = "tab";
          indent_size = 4;
        };
      };
    };
  };
}
