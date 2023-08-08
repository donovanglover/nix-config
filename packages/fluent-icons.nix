{ stdenvNoCC
, fetchurl
, unar
}:

stdenvNoCC.mkDerivation {
  pname = "fluent-icons";
  version = "2023-08-07";

  src = fetchurl {
    name = "Fluent Icons.zip";
    url = "https://files.catbox.moe/a6iswm.zip";
    hash = "sha256-LsMZr+RedK2Vi21K44A/vpBv54BISjshZ2+iAlMYASU=";
  };

  nativeBuildInputs = [ unar ];

  unpackPhase = /* bash */ ''
    runHook preUnpack

    cp "$src" $(stripHash "$src")
    unar $(stripHash "$src")

    runHook postUnpack
  '';

  #
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
