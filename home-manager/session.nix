_: {
  services.gnome-keyring = {
    enable = true;
    components = ["pkcs11" "secrets" "ssh"];
  };

  services.hyprpolkitagent.enable = true;

  xdg = {
    terminal-exec.enable = true;
    mimeApps.enable = true;
    userDirs.enable = true;
  };
}
