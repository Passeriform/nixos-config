{pkgs, ...}: {
  imports = [
    ./gtk.nix
    ./bindings.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      general = {
        gaps_in = 4;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(c4a7e7ff) rgba(ea9a97ff) 45deg";
        "col.inactive_border" = "rgba(2a273fcc)";
        layout = "dwindle";
      };

      monitor = ["eDP-2,2560x1440@240,0x0,1.25"];

      input = {
        numlock_by_default = true;
        touchpad.natural_scroll = true;
      };

      decoration = {
        rounding = 8;
        active_opacity = 0.9;
        inactive_opacity = 0.8;
        blur = {
          enabled = true;
          size = 10;
          passes = 2;
        };
      };

      animations = {
        enabled = "yes";
        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"
        ];
        animation = [
          "windows, 1, 3, myBezier"
          "windowsOut, 1, 3, default, popin 80%"
          "border, 1, 5, default"
          "workspaces, 1, 3, default"
        ];
      };

      exec-once = [
        "ambxst > ~/.logs/ambxst.log"
        "[workspace 2 silent] zen-beta"
        "[workspace 3 silent] codium"
        "[workspace 5 silent] vesktop"
        "[workspace 6 silent] spotify"
      ];
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
  };
}
