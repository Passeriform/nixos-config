{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [foot];

  programs.foot = {
    enable = true;
    settings = {
      colors-dark.background = "0a0a0a";
      main = {
        font = "Iosevka Nerd Font:size=11";
        pad = "20x10";
      };
    };
  };

  xdg = {
    terminal-exec.settings.default = ["foot.desktop"];
    mimeApps = let
      associations = builtins.listToAttrs (map (mime: {
        name = mime;
        value = "foot.desktop";
      }) ["x-scheme-handler/ssh" "x-scheme-handler/terminal"]);
    in
      lib.mkIf config.xdg.mimeApps.enable {
        defaultApplicationPackages = with pkgs; [foot];
        associations.added = associations;
        defaultApplications = associations;
      };
  };
}
