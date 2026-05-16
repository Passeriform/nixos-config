{inputs, ...}: {
  imports = [
    inputs.ambxst-hm.homeModules.default
  ];

  programs = {
    quickshell = {
      enable = true;
      systemd.enable = true;
    };

    ambxst = {
      enable = true;
      face = ../../assets/bird.svg;
      mutagenScheme = "scheme-tonal-spot";
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
