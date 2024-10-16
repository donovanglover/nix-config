{
  lib,
  stdenvNoCC,
  fetchFromGitea,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "friendlyfox";
  version = "3.1.0";

  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "user0";
    repo = "Mobile-Friendly-Firefox";
    rev = "v${finalAttrs.version}";
    hash = "sha256-4y7rSAQT6N9VIQhRVyfLBCIb+bIUUOSawURywRCcb7c=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm644 src/userContent/styles/fenix-colors/userContent.css -t $out
    cat src/userChrome/fenix_one.css src/userChrome/dynamic_popups_pro.css > $out/userChrome.css

    runHook postInstall
  '';

  postInstall = ''
    echo ".urlbarView { display: none !important; }" >> $out/userChrome.css
  '';

  meta = {
    description = "Custom CSS styles for Firefox browsers on Linux, with a focus on mobile devices like Librem 5 and PinePhone";
    license = lib.licenses.mpl20;
    homepage = "https://codeberg.org/user0/Mobile-Friendly-Firefox";
    maintainers = with lib.maintainers; [ donovanglover ];
    platforms = lib.platforms.all;
  };
})
