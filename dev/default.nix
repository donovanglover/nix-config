{ pkgs, ... }:

{
  programs.npm.enable = true;

  home-manager.sharedModules = [{
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

        "*.md".indent_style = "tab";

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
  }];

  environment.systemPackages = with pkgs; [
    marksman
    lua-language-server
    clang-tools
    texlab

    # go
    go
    gopls

    # nix
    nil
    nixfmt
    nixos-generators

    # node/yarn/deno
    nodejs
    yarn
    deno

    # rust
    gcc
    rustc
    rustfmt
    cargo
    rust-analyzer
    bacon
  ];
}
