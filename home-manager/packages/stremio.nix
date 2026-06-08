{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [stremio-linux-shell];

  xdg = {
    mimeApps = let
      associations = builtins.listToAttrs (map (mime: {
        name = mime;
        value = "com.stremio.Stremio.desktop";
      }) ["x-scheme-handler/magnet" "application/x-bittorrent"]);
    in
      lib.mkIf config.xdg.mimeApps.enable {
        defaultApplicationPackages = with pkgs; [stremio-linux-shell];
        associations.added = associations;
        defaultApplications = associations;
      };
  };
}
