{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [stremio-linux-shell];

  xdg = {
    mimeApps = lib.mkIf config.xdg.mimeApps.enable {
      defaultApplicationPackages = with pkgs; [stremio-linux-shell];
    };
  };
}
