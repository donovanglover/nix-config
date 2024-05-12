{ lib
, buildNpmPackage
, fetchFromGitHub
}:

buildNpmPackage rec {
  pname = "all-the-package-names";
  version = "2.0.1490";

  src = fetchFromGitHub {
    owner = "nice-registry";
    repo = "all-the-package-names";
    rev = "v${version}";
    hash = "sha256-sUJtg/sxNWdkN90AmqVRo5g0BaD9ej/Ha6kJamwO5iA=";
  };

  npmDepsHash = "sha256-xXC6HA7rILtOWcqWlGye883HZGwiaQws16mlJaDqDQE=";

  meta = {
    description = "A list of all the public package names on npm";
    homepage = "https://github.com/nice-registry/all-the-package-names";
    license = lib.licenses.mit;
    mainProgram = "all-the-package-names";
    maintainers = with lib.maintainers; [ donovanglover ];
  };
}
