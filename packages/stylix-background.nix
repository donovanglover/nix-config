{
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
}
