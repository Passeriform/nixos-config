{username, ...}: {
  imports = [
    ./packages
    ./mounts.nix
    ./session.nix
    ./devshell.nix
    ./fonts.nix
    ./cursor.nix
    ./utils.nix
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
  };

  systemd.user.startServices = "sd-switch";
  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
