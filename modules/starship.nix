{
  programs = {
    neovim.enable = true;
    direnv.enable = true;
  };

  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;

      directory = {
        style = "purple";
        read_only = " ro";
      };

      git_branch = {
        style = "yellow";
        symbol = "";
      };

      character = {
        success_symbol = "[>](red)[>](green)[>](blue)";
        error_symbol = "[>](cyan)[>](purple)[>](yellow)";
        vicmd_symbol = "[<](bold green)";
      };

      line_break.disabled = true;

      nodejs = {
        format = "with [$symbol($version )]($style)";
        symbol = "node ";
        version_format = "\${major}";
        disabled = true;
      };

      git_commit.tag_symbol = " tag ";

      git_status = {
        ahead = ">";
        behind = "<";
        diverged = "<>";
        renamed = "r";
        deleted = "x";
      };

      aws.symbol = "aws ";
      cobol.symbol = "cobol ";
      conda.symbol = "conda ";
      crystal.symbol = "cr ";
      cmake.symbol = "cmake ";
      dart.symbol = "dart ";
      deno.symbol = "deno ";
      dotnet.symbol = ".NET ";
      docker_context.symbol = "docker ";
      elixir.symbol = "exs ";
      elm.symbol = "elm ";
      golang.symbol = "go ";
      hg_branch.symbol = "hg ";
      java.symbol = "java ";
      julia.symbol = "jl ";
      kotlin.symbol = "kt ";
      memory_usage.symbol = "memory ";
      nim.symbol = "nim ";

      nix_shell = {
        format = "❄️ ";
        symbol = "nix ";
      };

      ocaml.symbol = "ml ";
      package.symbol = "pkg ";
      perl.symbol = "pl ";
      php.symbol = "php ";
      purescript.symbol = "purs ";
      python.symbol = "python ";
      ruby.symbol = "ruby ";

      rust = {
        symbol = "rust ";
        disabled = true;
      };

      bun = {
        symbol = "bun ";
        disabled = true;
      };

      scala.symbol = "scala ";
      swift.symbol = "swift ";
    };
  };
}
