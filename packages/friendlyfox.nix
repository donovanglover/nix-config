{
  lib,
  stdenvNoCC,
  fetchFromGitea,
  fetchpatch2,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "friendlyfox";
  version = "2.11.1";

  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "user0";
    repo = "Mobile-Friendly-Firefox";
    rev = "v${finalAttrs.version}";
    hash = "sha256-rA5lnfW5zOyfJ6pbcrsTBEhMEof5h/heGaHxST+q+AY=";
  };

  patches = [
    # Fix for Firefox 127 and later (renamed id)
    (fetchpatch2 {
      url = "https://codeberg.org/user0/Mobile-Friendly-Firefox/commit/bfb7946973bf707d0494714679df47ec66017f97.patch";
      hash = "sha256-wJLXgNUUaNHVgCMi8sGnC5cx2yNwZwh2JoDaVMsVehY=";
    })
  ];

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
    homepage = "https://forums.puri.sm/t/tutorial-add-a-custom-background-in-phosh/13385/23";
    maintainers = with lib.maintainers; [ donovanglover ];
    platforms = lib.platforms.all;
  };
})
