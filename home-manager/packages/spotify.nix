{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      powerBar
      seekSong
      playlistIcons
      songStats
      history
      betterGenres
      oneko
      catJamSynced
      shuffle
    ];
    theme = spicePkgs.themes.ziro;
  };

  xdg.mimeApps.defaultApplicationPackages = with pkgs; [spotify];
}
