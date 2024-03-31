(final: prev: {
  base16-schemes = prev.base16-schemes.overrideAttrs (oldAttrs: {
    version = "unstable-2023-05-02";

    src = prev.fetchFromGitHub {
      owner = "tinted-theming";
      repo = "base16-schemes";
      rev = "9a4002f78dd1094c123169da243680b2fda3fe69";
      hash = "sha256-AngNF++RZQB0l4M8pRgcv66pAcIPY+cCwmUOd+RBJKA=";
    };

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/themes/
      install *.yaml $out/share/themes/

      runHook postInstall
    '';
  });
})
