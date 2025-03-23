{
  fetchzip,
  stdenv,
  stdenvNoCC,
  buildGoModule,
  makeWrapper,
  scdoc,
  fetchFromSourcehut,
  dotool,
  lib,
  alsa-utils,
  libxkbcommon,
  gnused,
  gawk,
  coreutils,
  libnotify,
  dmenu,
  procps,
  installShellFiles,
}:

let
  vosk-bin = stdenvNoCC.mkDerivation (finalAttrs: {
    pname = "vosk-bin";
    version = "0.3.45";

    src = fetchzip {
      url = "https://github.com/alphacep/vosk-api/releases/download/v${finalAttrs.version}/vosk-linux-x86_64-${finalAttrs.version}.zip";
      hash = "sha256-ToMDbD5ooFMHU0nNlfpLynF29kkfMknBluKO5PipLFY=";
    };

    installPhase = ''
      runHook preInstall

      install -Dm644 libvosk.so -t $out/lib
      install -Dm644 vosk_api.h -t $out/include

      runHook postInstall
    '';
  });

  vosk-model-small-en-us = stdenvNoCC.mkDerivation (finalAttrs: {
    pname = "vosk-model-small-en-us";
    version = "0.15";

    src = fetchzip {
      url = "https://alphacephei.com/vosk/models/vosk-model-small-en-us-${finalAttrs.version}.zip";
      hash = "sha256-CIoPZ/krX+UW2w7c84W3oc1n4zc9BBS/fc8rVYUthuY=";
    };

    patchPhase = ''
      runHook prePatch

      echo "--endpoint.rule2.min-trailing-silence=0.5" >> ./conf/model.conf
      echo "--endpoint.rule3.min-trailing-silence=0.5" >> ./conf/model.conf
      echo "--endpoint.rule4.min-trailing-silence=0.6" >> ./conf/model.conf

      runHook postPatch
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/usr/share/vosk-models
      cp -r . $out/usr/share/vosk-models/small-en-us

      runHook postInstall
    '';
  });
in
buildGoModule rec {
  pname = "numen";
  version = "0.7";

  src = fetchFromSourcehut {
    owner = "~geb";
    repo = "numen";
    rev = version;
    hash = "sha256-ia01lOP59RdoiO23b5Dv5/fX5CEI43tPHjmaKwxP+OM=";
  };

  vendorHash = "sha256-Y3CbAnIK+gEcUfll9IlEGZE/s3wxdhAmTJkj9zlAtoQ=";

  nativeBuildInputs = [
    makeWrapper
    scdoc
    installShellFiles
  ];

  ldflags = [
    "-X main.Version=${version}"
    "-X main.DefaultModelPackage=vosk-model-small-en-us"
    "-X main.DefaultModelPaths=${vosk-model-small-en-us}/usr/share/vosk-models/small-en-us"
    "-X main.DefaultPhrasesDir=${placeholder "out"}/etc/numen/phrases"
  ];

  env = {
    CGO_CFLAGS = "-I${vosk-bin}/include";
    CGO_LDFLAGS = "-L${vosk-bin}/lib";
    NUMEN_SKIP_BINARY = "yes";
    NUMEN_SKIP_CHECKS = "yes";
    NUMEN_DEFAULT_PHRASES_DIR = "/etc/numen/phrases";
    NUMEN_SCRIPTS_DIR = "/etc/numen/scripts";
  };

  patchPhase = ''
    runHook prePatch

    substituteInPlace scripts/* \
      --replace-warn /etc/numen/scripts/ "numen-" \
      --replace-warn sed ${lib.getExe gnused} \
      --replace-warn awk ${lib.getExe gawk} \
      --replace-warn cat ${coreutils}/bin/cat \
      --replace-warn notify-send ${lib.getExe libnotify}

    substituteInPlace scripts/menu \
      --replace-warn "-dmenu" "-${lib.getExe dmenu}"

    substituteInPlace scripts/displaying \
      --replace-warn "(pgrep" "(${procps}/bin/pgrep" \
      --replace-warn "(ps" "(${procps}/bin/ps"

    substituteInPlace phrases/* \
      --replace-warn /etc/numen/scripts/ "numen-"

    substituteInPlace numenc \
      --replace-warn /bin/echo "${coreutils}/bin/echo" \
      --replace-warn cat "${coreutils}/bin/cat"

    runHook postPatch
  '';

  installPhase = ''
    runHook preInstall

    install -Dm755 $GOPATH/bin/numen -t $out/bin

    for file in ./scripts/*; do
      cp "$file" "$out/bin/numen-$(basename $file)"
    done

    ./install-numen.sh $out /bin

    runHook postInstall
  '';

  postInstall = ''
    scdoc < doc/numen.1.scd > numen.1
    installManPage numen.1
  '';

  postFixup = ''
    wrapProgram $out/bin/numen \
      --prefix PATH : ${
        lib.makeBinPath [
          dotool
          alsa-utils
        ]
      } \
      --prefix LD_LIBRARY_PATH : ${
        lib.makeLibraryPath [
          libxkbcommon
          stdenv.cc.cc.lib
        ]
      }
  '';

  meta = {
    homepage = "https://git.sr.ht/~geb/numen";
    description = "Voice control for handsfree computing";
    license = lib.licenses.agpl3Only;
    maintainers = with lib.maintainers; [ donovanglover ];
    mainProgram = "numen";
    platforms = lib.platforms.linux;
  };
}
