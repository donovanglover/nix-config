{
  lib,
  stdenvNoCC,
  fluent-icon-theme,
  fd,
  inkscape,
}:

stdenvNoCC.mkDerivation {
  pname = "fluent-icons";
  version = "2024-01-02";

  dontUnpack = true;

  nativeBuildInputs = [
    fd
    inkscape
    fluent-icon-theme
  ];

  installPhase = ''
    runHook preInstall

    cp ${fluent-icon-theme}/share/icons/Fluent/scalable/places/default-* .
    fd -e svg -x inkscape -w 512 -h 512 "{}" -o "{.}.png"

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
