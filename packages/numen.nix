{
  fetchzip,
  stdenv,
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
  vosk-bin = stdenv.mkDerivation (finalAttrs: {
    name = "vosk-bin";
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

  vosk-model-small-en-us = stdenv.mkDerivation (finalAttrs: {
    name = "vosk-model-small-en-us";
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

  preBuild = ''
    export CGO_CFLAGS="-I${vosk-bin}/include"
    export CGO_LDFLAGS="-L${vosk-bin}/lib"
  '';

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

  patchPhase = ''
    runHook prePatch

    substituteInPlace scripts/* \
      --replace /etc/numen/scripts "$out/etc/numen/scripts" \
      --replace sed ${gnused}/bin/sed \
      --replace awk ${gawk}/bin/awk \
      --replace cat ${coreutils}/bin/cat \
      --replace notify-send ${libnotify}/bin/notify-send

    substituteInPlace scripts/menu \
      --replace "-dmenu" "-${dmenu}/bin/dmenu"

    substituteInPlace scripts/displaying \
      --replace "(pgrep" "(${procps}/bin/pgrep" \
      --replace "(ps" "(${procps}/bin/ps"

    substituteInPlace phrases/* \
      --replace /etc/numen/scripts "$out/etc/numen/scripts" \
      --replace numenc "$out/bin/numenc"

    substituteInPlace numenc \
      --replace /bin/echo "${coreutils}/bin/echo" \
      --replace cat "${coreutils}/bin/cat" \

    runHook postPatch
  '';

  installPhase = ''
    runHook preInstall

    install -Dm755 $GOPATH/bin/numen -t $out/bin

    export NUMEN_SKIP_BINARY=yes
    export NUMEN_SKIP_CHECKS=yes
    export NUMEN_DEFAULT_PHRASES_DIR=/etc/numen/phrases
    export NUMEN_SCRIPTS_DIR=/etc/numen/scripts

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
      } \
  '';
}
