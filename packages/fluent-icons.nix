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

  installPhase = /* bash */ ''
    runHook preInstall

    mkdir -p $out
    cp -r * $out

    runHook postInstall
  '';

  meta = with lib; {
    description = "Fluent folder icons converted to png";
    homepage = "https://github.com/vinceliuice/Fluent-icon-theme";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ donovanglover ];
    platforms = platforms.all;
  };
}
