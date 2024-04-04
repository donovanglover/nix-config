{ pkgs, ... }:

{
  services.postgresql = {
    enable = true;

    ensureUsers = [
      {
        name = "user";
      }
      {
        name = "cooldbname";
        ensureDBOwnership = true;
      }
    ];

    ensureDatabases = [
      "cooldbname"
    ];
  };

  environment.systemPackages = with pkgs; [
    pgcli
  ];
}
