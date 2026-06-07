{
  pkgs,
  username,
  ...
}: {
  services.asusd.enable = true;
  services.supergfxd.enable = true;

  systemd.services.asusd.serviceConfig = {
    StateDirectory = "asusd";
    ConfigurationDirectory = "asusd";
  };

  users.users."${username}".extraGroups = ["video" "plugdev"];
}
