let VARIABLES = import ../src/variables.nix; in {
  i18n.defaultLocale = VARIABLES.defaultLocale;
  i18n.supportedLocales = VARIABLES.supportedLocales;
}
