{
  lib,
  stdenvNoCC,
  imagemagick,
  color ? "181818",
}:

stdenvNoCC.mkDerivation {
  pname = "stylix-background";
  version = "1.0.0-${color}";

  dontUnpack = true;

  nativeBuildInputs = [ imagemagick ];

  postInstall = ''
    mkdir -p $out
    magick -size 1x1 xc:#${color} $out/wallpaper.png
  '';

  meta = {
    description = "Solid background color for stylix to use";
    license = lib.licenses.publicDomain;
    homepage = "https://stackoverflow.com/questions/7771975/imagemagick-create-a-png-file-which-is-just-a-solid-rectangle";
    maintainers = with lib.maintainers; [ donovanglover ];
    platforms = lib.platforms.all;
  };
}
