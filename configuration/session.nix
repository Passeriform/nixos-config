{
  inputs,
  pkgs,
  ...
}: let
  sddm-theme = inputs.catppuccin-where-is-my-sddm-theme.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
  environment.systemPackages = with pkgs; [
    hyprpolkitagent
    (sddm-theme.override {flavor = "mocha";})
  ];

  security.polkit.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  services.gnome.gnome-keyring.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "where_is_my_sddm_theme";
    extraPackages = with pkgs; [
      kdePackages.qt5compat
    ];
    enableHidpi = true;
  };
}
