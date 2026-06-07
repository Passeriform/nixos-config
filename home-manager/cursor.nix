{pkgs, ...}: {
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.ghostline-cursor-theme;
    name = "Ghostline Dark";
    size = 32;
  };
}
