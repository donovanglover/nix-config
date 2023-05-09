{ config, lib, nixpkgs, home-manager, ... }: {
  imports = [ home-manager.nixosModule ];
  home-manager.users.user = { pkgs, ... }: {
    programs.neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        {
          plugin = nvim-tree-lua;
          type = "lua";
          config = ''
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            vim.opt.termguicolors = true
            require("nvim-tree").setup()
          '';
        }
        {
          plugin = indent-blankline-nvim;
          type = "lua";
          config = ''
            vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]]
            require("indent_blankline").setup {
              char = "",
              char_highlight_list = {
                "IndentBlanklineIndent1",
                "IndentBlanklineIndent2",
              },
              space_char_highlight_list = {
                "IndentBlanklineIndent1",
                "IndentBlanklineIndent2",
              },
              show_trailing_blankline_indent = false,
            }
          '';
        }
      ];
    };
  };
}
