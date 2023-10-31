{
  nixpkgs.overlays = [
    (final: prev: {
      hyprnome = prev.hyprnome.overrideAttrs (oldAttrs: rec {
        version = "0.2.0";

        src = prev.fetchFromGitHub {
          owner = "donovanglover";
          repo = "hyprnome";
          rev = version;
          hash = "sha256-zlXiT2EOIdgIDI4NQuU3C903SSq5bylBAFJXyv7mdJ4=";
        };

        cargoDeps = oldAttrs.cargoDeps.overrideAttrs (prev.lib.const {
          name = "hyprnome-vendor.tar.gz";
          inherit src;
          outputHash = "sha256-HNKjEwryfado8kDsdt6BRMQU/uPqytRztJANw4Mnw/Y=";
        });

        postInstall = ''
          installManPage target/man/hyprnome.1

          installShellCompletion --cmd hyprnome \
            --bash <(cat target/completions/hyprnome.bash) \
            --fish <(cat target/completions/hyprnome.fish) \
            --zsh <(cat target/completions/_hyprnome)
        '';
      });
    })
  ];
}
