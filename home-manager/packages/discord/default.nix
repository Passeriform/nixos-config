{inputs, ...}: {
  imports = [inputs.nixcord.homeModules.default];

  programs.nixcord = {
    enable = true;
    discord.enable = false;
    vesktop = {
      enable = true;
      settings = {
        # hardwareVideoAcceleration = true;
      };
    };

    config = {
      frameless = true;
      useQuickCss = true;

      enabledThemes = ["ambxst.css"];

      plugins = {
        alwaysAnimate.enable = true;
        alwaysTrust.enable = true;
        copyFileContents.enable = true;
        clearUrls.enable = true;
        copyUserUrls.enable = true;
        disableCallIdle.enable = true;
        experiments.enable = true;
        fakeNitro.enable = true;
        favoriteEmojiFirst.enable = true;
        fixCodeblockGap.enable = true;
        fixYoutubeEmbeds.enable = true;
        gifPaste.enable = true;
        oneko.enable = true;
        openInApp.enable = true;
        petpet.enable = true;
        shikiCodeblocks.enable = true;
        silentTyping.enable = true;
        spotifyCrack = {
          enable = true;
          noSpotifyAutoPause = true;
        };
        validReply.enable = true;
        validUser.enable = true;
        youtubeAdblock.enable = true;
        webScreenShareFixes.enable = true;
      };
    };
  };

  xdg.configFile = {
    "vesktop/userAssets/splash".source = ./assets/splash.webp;
    "vesktop/userAssets/tray".source = ./assets/tray.png;
    "vesktop/userAssets/trayUnread".source = ./assets/trayUnread.png;
  };
}
