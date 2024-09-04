{
  lib,
  stdenvNoCC,
  fetchurl,
  fd,
  imagemagick,
  color ? "181818",
}:

stdenvNoCC.mkDerivation {
  pname = "phosh-backgrounds";
  version = "1.0.0";

  srcs = [
    (fetchurl {
      name = "wall-panel.jpg";
      url = "https://forums.puri.sm/uploads/default/original/2X/e/ebaa0cf196c1dd9a63cbdb3ddb7c57b1d443b559.jpeg";
      hash = "sha256-hXMUb5rxbRcW1VYT5gZyUAuyJwZNyyGbHHKLIpkXv8w=";
    })

    (fetchurl {
      name = "wall-lock.jpg";
      url = "https://forums.puri.sm/uploads/default/original/2X/e/e056aea7bf5bb8b7a75dc6b95ec296c7e0a62303.jpeg";
      hash = "sha256-ot4loxl4OZ/zgbWwSfdqZL5upg6+Svuua2GOwPRYY9E=";
    })

    (fetchurl {
      name = "wall-home.jpg";
      url = "https://forums.puri.sm/uploads/default/original/2X/1/1d508f9b773c46118f5380a1cf2c619916817245.jpeg";
      hash = "sha256-h+jCKp7Wyu0ETxcM7KTBpLz2Sxo9gwfY3GQIOGUOXQg=";
    })

    (fetchurl {
      name = "wall-grid.jpg";
      url = "https://forums.puri.sm/uploads/default/original/2X/e/eb02bc8f16cf485e1a5f6aae076bfaa79f5fba70.jpeg";
      hash = "sha256-McGHFrwLh7jDYWCPDC14GM85Uc74RpdgMqSgAtMDeaQ=";
    })
  ];

  nativeBuildInputs = [
    fd
    imagemagick
  ];

  unpackPhase = ''
    runHook preUnpack

    for srcFile in $srcs; do
      cp $srcFile $(stripHash $srcFile)
    done

    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    fd -e jpg -x magick "{}" -fill "#${color}" -colorize 30% "$out/{.}.jpg"

    runHook postInstall
  '';

  meta = {
    description = "Custom background for Phosh with seamless picture for a full-screen background image";
    license = lib.licenses.cc-by-sa-40;
    homepage = "https://forums.puri.sm/t/tutorial-add-a-custom-background-in-phosh/13385/23";
    maintainers = with lib.maintainers; [ donovanglover ];
    platforms = lib.platforms.all;
  };
}
