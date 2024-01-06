{ stdenvNoCC
, fetchurl
, unar
}:

stdenvNoCC.mkDerivation {
  pname = "fluent-icons";
  version = "2024-01-02";

  src = fetchurl {
    name = "Fluent Icons.zip";
    url = "https://files.catbox.moe/1we56t.zip";
    hash = "sha256-J530v9QRGv/c0PBYcCVpGSgqvirlx4eQzsP+Kqhft8A=";
  };

  nativeBuildInputs = [ unar ];

  unpackPhase = /* bash */ ''
    runHook preUnpack

    cp "$src" $(stripHash "$src")
    unar $(stripHash "$src")

    runHook postUnpack
  '';

  installPhase = /* bash */ ''
    runHook preInstall

    mkdir -p $out/share/eww
    cp -r */ $out/share/eww

    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/vinceliuice/Fluent-icon-theme";
    description = "Fluent folder icons converted to png";
  };
}
