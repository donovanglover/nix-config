{ lib
, stdenvNoCC
, fetchzip
}:

stdenvNoCC.mkDerivation {
  pname = "fluent-icons";
  version = "2024-01-02";

  src = fetchzip {
    url = "https://files.catbox.moe/1we56t.zip";
    hash = "sha256-gs33iDv+u6O03a+/QvDtKt/aHduZww4F3Fm3F40d1GI=";
    stripRoot = false;
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r * $out

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
