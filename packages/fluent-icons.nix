{
  lib,
  stdenvNoCC,
  fluent-icon-theme,
  fd,
  inkscape,
  lutgen,
  fetchFromGitHub,
}:

let
  lutgen' = lutgen.overrideAttrs (oldAttrs: rec {
    version = "0.8.3-unstable-2023-08-31";

    src = fetchFromGitHub {
      owner = "ozwaldorf";
      repo = "lutgen-rs";
      rev = "transparency";
      hash = "sha256-6jaRyZsp9GVYAihE8lcslwpDtcKJfC2KZbXw0MFJNRY=";
    };

    cargoDeps = oldAttrs.cargoDeps.overrideAttrs (
      lib.const {
        name = "${oldAttrs.pname}-${version}-vendor.tar.gz";
        inherit src;
        outputHash = "sha256-GmGEq7uUvfKtMP8TyA3lnih8KuZCdd6req0fBMFoX/M=";
      }
    );
  });
in
stdenvNoCC.mkDerivation {
  pname = "fluent-icons";
  version = "2024-01-02";

  dontUnpack = true;

  nativeBuildInputs = [
    fd
    inkscape
    fluent-icon-theme
    lutgen'
  ];

  installPhase = ''
    runHook preInstall

    cp ${fluent-icon-theme}/share/icons/Fluent/scalable/places/default-* .
    fd -e svg -x inkscape -w 128 -h 128 "{}" -o "{.}.png"
    fd -e png -x lutgen apply -o "{}" -p monokai-base16 --transparency "{}"

    install -Dm644 *.png -t $out

    runHook postInstall
  '';

  meta = {
    description = "Fluent folder icons converted to png";
    homepage = "https://github.com/vinceliuice/Fluent-icon-theme";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ donovanglover ];
    platforms = lib.platforms.all;
  };
}
