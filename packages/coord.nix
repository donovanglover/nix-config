{
  lib,
  fetchFromSourcehut,
  python3Packages,
}:

python3Packages.buildPythonApplication rec {
  pname = "coord";
  version = "1.0";

  src = fetchFromSourcehut {
    owner = "~geb";
    repo = "coord";
    rev = version;
    hash = "sha256-noEU8VXrFjhXd39R0Ps9m1/K2lt4fOXsjnNuVCDlknM=";
  };

  format = "other";

  dependencies = with python3Packages; [
    pyqt6
  ];

  installPhase = ''
    runHook preInstall

    install -Dm755 $src/coord $out/bin/coord

    runHook postInstall
  '';

  meta = {
    homepage = "https://git.sr.ht/~geb/coord";
    description = "Screen coordinate selector";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ donovanglover ];
    mainProgram = "coord";
    platforms = lib.platforms.linux;
  };
}
