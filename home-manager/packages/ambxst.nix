{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [inputs.ambxst-hm.homeModules.default];

  programs = {
    ambxst = {
      enable = true;
      face = ../../assets/bird.svg;
      mutagenScheme = "scheme-rose-pine";
      config = {
        bar = {
          launcherIcon = ../../assets/bird.svg;
          enableFirefoxPlayer = true;
          pillStyle = "squished";
          showPinButton = false;
        };
        theme = {
          oledMode = true;
          font = "Iosevka Nerd Font Mono";
        };
      };

      wallpaperDirectory = ../../wallpapers;
      # TODO: Make this configurable through keybindings
      wallpaperSelector = "sunpixels";
    };
  };

  xdg.mimeApps = let
    associations = builtins.listToAttrs (map (mime: {
      name = mime;
      value = "be.alexandervanhee.gradia.desktop";
    }) ["image/jpg" "image/bmp"]);
  in
    lib.mkIf config.xdg.mimeApps.enable {
      defaultApplicationPackages = with pkgs; [gradia];
      associations.added = associations;
      defaultApplications = associations;
    };
}
