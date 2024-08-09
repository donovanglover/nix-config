{
  lib,
  stdenvNoCC,
  writeTextFile,
  makeWrapper,
  fish,
  git,
  fd,
  jq,
  nixf,
}:

let
  script = writeTextFile {
    name = "nixf-tidy";
    text = # fish
      ''
        #!/usr/bin/env fish

        if test "$(git rev-parse --is-inside-work-tree)" != "true"
          echo "Not inside a git directory. Aborting."
          exit 1
        end

        echo "⚪ Checking for issues with nixf-tidy..."

        set DID_ERROR 0

        for FILE in **/*.nix
          set RESULT $(cat "$FILE" | nixf-tidy --variable-lookup)

          if test "$RESULT" != "[]"
            echo "===================================="
            echo "❌ nixd found issues in $FILE:"
            echo "===================================="
            echo "$RESULT" | jq ".[] | .message, .args, .range.lCur.line"

            set DID_ERROR 1
          else
            echo "✅ $FILE"
          end
        end

        exit $DID_ERROR
      '';
  };
in
stdenvNoCC.mkDerivation {
  pname = "nixf-tidy";
  version = "0.1.0";

  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    install -Dm755 ${script} $out/bin/nixf-tidy

    runHook postInstall
  '';

  postInstall = ''
    wrapProgram $out/bin/nixf-tidy \
      --prefix PATH ":" "${
        lib.makeBinPath [
          fish
          git
          fd
          jq
          nixf
        ]
      }"
  '';

  meta = {
    homepage = "https://github.com/nix-community/nixd/blob/main/libnixf/README.md#nixf-tidy";
    description = "Dedicated tool tailored for linting Nix projects";
    license = lib.licenses.lgpl3Plus;
    maintainers = with lib.maintainers; [ donovanglover ];
    mainProgram = "nixf-tidy";
    platforms = lib.platforms.linux;
  };
}
