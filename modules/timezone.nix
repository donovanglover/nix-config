let VARIABLES = import ../src/variables.nix; in {
  time.timeZone = "${VARIABLES.timezone}";
}
