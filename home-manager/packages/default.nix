_: {
  imports = [
    ./git.nix
    ./zsh.nix
    ./hyprland
    ./ambxst.nix
    ./foot.nix
    ./zen.nix
    ./vscode
    ./spotify.nix
    ./discord.nix
    ./stremio.nix
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
