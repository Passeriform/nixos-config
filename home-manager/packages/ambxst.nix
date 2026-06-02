{inputs, ...}: {
  imports = [
    inputs.ambxst-hm.homeModules.default
  ];

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
      # TODO: Make this configurable through keybinds
      wallpaperSelector = "sunpixels";
    };
  };
}
