{ stdenvNoCC
, libwebp
}:

stdenvNoCC.mkDerivation {
  pname = "webp-thumbnailer";
  version = "1.0.0";

  dontUnpack = true;

  postInstall = /* bash */ ''
    mkdir -p $out/share/thumbnailers

    echo "[Thumbnailer Entry]"                            >> $out/share/thumbnailers/webp.thumbnailer
    echo "Exec=${libwebp}/bin/dwebp %i -scale %s 0 -o %o" >> $out/share/thumbnailers/webp.thumbnailer
    echo "MimeType=image/x-webp;image/webp;"              >> $out/share/thumbnailers/webp.thumbnailer
  '';

  meta = {
    homepage = "https://github.com/liquuid/nautilus-webp-thumbnailer";
    description = "Create thumbnails from webp files";
  };
}
