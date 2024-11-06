{
  lib,
  stdenvNoCC,
  fetchurl,
}:

let
  build = "b1923BC50731";
in
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "showdex";
  version = "1.2.5";

  src = fetchurl {
    url = "https://github.com/doshidak/showdex/releases/download/v${finalAttrs.version}/showdex-v${finalAttrs.version}-${build}.firefox.xpi";
    hash = "sha256-wn0pF8ar5Ldfc/kNMznzg9NAz+5ckZB7SCEUObj0BPw=";
  };

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -Dm644 "$src" "$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/showdex@tize.io.xpi"

    runHook postInstall
  '';

  passthru.updateScript = # fish
    ''
      set URL $(curl -s https://api.github.com/repos/doshidak/showdex/releases/latest | jq -r ".assets[] | select(.content_type == \"application/x-xpinstall\") | .browser_download_url")
      and set VERSION $(echo "$URL" | grep -Eo '[0-9\.]+-' | sd "-" "")
      and set BUILD $(echo "$URL" | grep -Eo 'b[A-Z0-9]+')
      and set HASH $(nix hash convert --to sri sha256:$(nix-prefetch-url "$URL"))

      and sd -n 1 'version = "[^"]*"' "version = \"$VERSION\"" ./packages/showdex.nix
      and sd -n 1 'build = "[^"]*"' "build = \"$BUILD\"" ./packages/showdex.nix
      and sd -n 1 'hash = "[^"]*"' "hash = \"$HASH\"" ./packages/showdex.nix
    '';

  meta = {
    homepage = "https://github.com/doshidak/showdex";
    description = "Pokémon Showdown extension that harnesses the power of parabolic calculus to strategically extract your opponents' Elo";
    license = lib.licenses.agpl3Only;
    maintainers = with lib.maintainers; [ donovanglover ];
    platforms = lib.platforms.all;
  };
})
