{username, ...}: {
  imports = [
    ./whitelist.nix
    ./hardware-configuration.nix
    ./system
    ./misc
    ./mounts.nix
    ./session.nix
    ./desktop.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = ["wheel"];
  };

  system.stateVersion = "26.05";
}
