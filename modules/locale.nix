let VARIABLES = import ./variables.nix; in {
  i18n.defaultLocale = VARIABLES.defaultLocale;
  i18n.supportedLocales = VARIABLES.supportedLocales;
}
