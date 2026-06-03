{
  pkgs,
  username,
  ...
}: {
  environment.systemPackages = with pkgs; [rog-control-center supergfxctl];

  services.asusd.enable = true;

  users.users."${username}".extraGroups = ["video" "plugdev"];
}
