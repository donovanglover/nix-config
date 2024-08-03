final: prev: {
  neovim-unwrapped = prev.neovim-unwrapped.overrideAttrs (oldAttrs: {
    postInstall =
      (oldAttrs.postInstall or "")
      # bash
      + ''
        substituteInPlace $out/share/applications/nvim.desktop \
          --replace "TryExec=nvim" "" \
          --replace "Terminal=true" "Terminal=false" \
          --replace "Exec=nvim %F" "Exec=kitty nvim %F"
      '';
  });
}
