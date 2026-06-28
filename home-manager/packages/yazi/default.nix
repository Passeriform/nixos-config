{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    _7zz
    resvg
    poppler-utils
  ];

  programs.yazi = {
    enable = true;
    flavors.flexoki-dark = pkgs.yaziFlavors.flexoki-dark;
    theme.flavor.dark = "flexoki-dark";

    theme.status = {
      sep_left = {
        close = "";
        open = "";
      };
      sep_right = {
        close = "";
        open = "";
      };
    };

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

    initLua = ./init.lua;

    plugins = {
      full-border = {
        package = pkgs.yaziPlugins.full-border;
        setup = true;
      };
      starship = {
        package = pkgs.yaziPlugins.starship;
        setup = true;
      };
      git = {
        package = pkgs.yaziPlugins.git;
        setup = true;
      };
      inherit (pkgs.yaziPlugins) glow ouch;
    };
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
