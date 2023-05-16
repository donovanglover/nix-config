{
  home-manager.sharedModules = [{
    programs.gpg = {
      enable = true;
      # homedir = "${config.xdg.dataHome}/gnupg"
      settings = {
        personal-digest-preferences = "SHA512";
        cert-digest-algo = "SHA512";
        cipher-algo = "AES256";
        default-preference-list = "SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed";
        personal-cipher-preferences = "TWOFISH CAMELLIA256 AES 3DES";
        throw-keyids = true;
        keyid-format = "0xlong";
        with-fingerprint = true;
      };
    };
  }];
}
