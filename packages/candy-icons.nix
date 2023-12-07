{ stdenvNoCC
, fetchurl
, unar
}:

stdenvNoCC.mkDerivation {
  pname = "candy-icons";
  version = "2023-12-07";

  src = fetchurl {
    name = "Candy Icons.zip";
    url = "https://files.catbox.moe/zn84ts.zip";
    hash = "sha256-X2P4SAERpXEkNX0w6qLS3BEbdYtQiST/cimdmrfFY6E=";
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
    homepage = "https://github.com/EliverLara/candy-icons";
    description = "Candy folder icons converted to png";
  };
}
