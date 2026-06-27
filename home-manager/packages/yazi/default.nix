{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [yazi];

  programs.yazi = {
    enable = true;
    flavors.flexoki-dark = pkgs.yaziFlavors.flexoki-dark;
    theme.flavor.dark = "flexoki-dark";

    settings = {
      mgr.show_hidden = true;
      preview.tab_size = 4;
      opener.edit = [
        {
          run = "codium %s";
          desc = "VSCode";
          block = true;
        }
      ];
    };

    plugins = builtins.listToAttrs (map (name: {
      inherit name;
      value = pkgs.yaziPlugins.${name};
    }) ["full-border" "git" "glow" "ouch" "starship"]);
  };

  xdg.mimeApps = let
    associations = builtins.listToAttrs (map (mime: {
      name = mime;
      value = "yazi.desktop";
    }) ["inode/directory"]);
  in
    lib.mkIf config.xdg.mimeApps.enable {
      defaultApplicationPackages = with pkgs; [yazi];
      associations.added = associations;
      defaultApplications = associations;
    };
}
