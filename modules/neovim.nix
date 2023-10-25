{
  programs.neovim.enable = true;
  programs.direnv.enable = true;

  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
