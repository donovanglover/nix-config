{
  lib,
  buildNpmPackage,
  fetchurl,
}:

buildNpmPackage (finalAttrs: {
  pname = "nadesiko3";
  version = "3.6.44";

  src = fetchurl {
    url = "https://registry.npmjs.org/nadesiko3/-/nadesiko3-${finalAttrs.version}.tgz";
    hash = "sha256-LSS/ieeyOUc3Q1bEfVqdNei4rIeG9Wz67TmCsGtrojU=";
  };

  npmDepsHash = "sha256-PBwdfNYnIjoaqXCZ7J28usC3HNbiQDz/NoREMhGL5TE=";

  postPatch = ''
    ln -s ${../assets/nadesiko3-package-lock.json} package-lock.json
  '';

  dontNpmBuild = true;

  passthru.updateScript = # fish
    ''
      set VERSION $(npm view nadesiko3 version)
      and set TARBALL "nadesiko3-$VERSION.tgz"
      and set URL "https://registry.npmjs.org/nadesiko3/-/$TARBALL"
      and set HASH $(nix hash convert --to sri sha256:$(nix-prefetch-url "$URL"))

      and xh -d "$URL"
      and tar xf "$TARBALL" --strip-components=1 package/package.json
      and npm install --package-lock-only --ignore-scripts
      and set NPM_HASH $(nix run nixpkgs#prefetch-npm-deps package-lock.json)

      and sd -n 1 'version = "[^"]*"' "version = \"$VERSION\"" ./packages/nadesiko3.nix
      and sd -n 1 'hash = "[^"]*"' "hash = \"$HASH\"" ./packages/nadesiko3.nix
      and sd -n 1 'npmDepsHash = "[^"]*"' "npmDepsHash = \"$NPM_HASH\"" ./packages/nadesiko3.nix

      and mv package-lock.json ./assets/nadesiko3-package-lock.json

      and rm package.json
      and rm nadesiko3-*.tgz
    '';

  meta = {
    description = "Japanese Programming Language Nadesiko v3 (JavaScript/TypeScript)";
    homepage = "https://nadesi.com";
    license = lib.licenses.mit;
    mainProgram = "cnako3";
    maintainers = with lib.maintainers; [ donovanglover ];
  };
})
