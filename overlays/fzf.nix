{
  nixpkgs.overlays = [
    (final: prev: {
      fzf = prev.fzf.overrideAttrs (oldAttrs: {
        postInstall = (oldAttrs.postInstall or "") + ''
          cat << EOF > $out/share/fish/vendor_conf.d/load-fzf-key-bindings.fish
            status is-interactive; or exit 0
            fzf_key_bindings
          EOF
        '';
      });
    })
  ];
}
