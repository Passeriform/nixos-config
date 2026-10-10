_: {
  services.qbittorrent = {
    enable = true;
    serverConfig = {
      LegalNotice.Accepted = true;
      Preferences.WebUI.LocalHostAuth = false;
    };
  };

  services.jackett.enable = true;
  services.flaresolverr.enable = true;
}
