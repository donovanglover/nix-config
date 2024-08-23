final: prev: {
  picom = prev.picom.overrideAttrs (oldAttrs: rec {
    version = "12-rc2";

    src = prev.fetchFromGitHub {
      owner = "yshui";
      repo = "picom";
      rev = "v${version}";
      hash = "sha256-59I6uozu4g9hll5U/r0nf4q92+zwRlbOD/z4R8TpSdo=";
    };

    nativeBuildInputs = oldAttrs.nativeBuildInputs ++ (with prev; [
      asciidoctor
    ]);
  });
}
