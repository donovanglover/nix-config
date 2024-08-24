{
  programs.ripgrep = {
    enable = true;

    arguments = [
      "--max-columns=2000"
      "--smart-case"
    ];
  };
}
