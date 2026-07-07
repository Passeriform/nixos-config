_: {
  wayland.windowManager.hyprland.settings = let
    navigation = [
      "SUPER, UP, movefocus, u"
      "SUPER, RIGHT, movefocus, r"
      "SUPER, DOWN, movefocus, d"
      "SUPER, LEFT, movefocus, l"

      "SUPER, 1, workspace, 1"
      "SUPER, 2, workspace, 2"
      "SUPER, 3, workspace, 3"
      "SUPER, 4, workspace, 4"
      "SUPER, 5, workspace, 5"
      "SUPER, 6, workspace, 6"
      "SUPER, 7, workspace, 7"
      "SUPER, 8, workspace, 8"
      "SUPER, 9, workspace, 9"
      "SUPER, 0, workspace, 10"

      "SUPER SHIFT, 1, movetoworkspace, 1"
      "SUPER SHIFT, 2, movetoworkspace, 2"
      "SUPER SHIFT, 3, movetoworkspace, 3"
      "SUPER SHIFT, 4, movetoworkspace, 4"
      "SUPER SHIFT, 5, movetoworkspace, 5"
      "SUPER SHIFT, 6, movetoworkspace, 6"
      "SUPER SHIFT, 7, movetoworkspace, 7"
      "SUPER SHIFT, 8, movetoworkspace, 8"
      "SUPER SHIFT, 9, movetoworkspace, 9"
      "SUPER SHIFT, 0, movetoworkspace, 10"
    ];

    window_E = [
      "SUPER CONTROL, UP, resizeactive, 0 -10"
      "SUPER CONTROL, RIGHT, resizeactive, 10 0"
      "SUPER CONTROL, DOWN, resizeactive, 0 10"
      "SUPER CONTROL, LEFT, resizeactive, -10 0"
    ];

    window = [
      "SUPER, SPACE, togglefloating"
      "SUPER, F, fullscreen"
      "SUPER, Q, killactive"
    ];

    window_M = [
      "SUPER, mouse:272, movewindow"
    ];

    specialKeys_LE = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ", XF86MonBrightnessUp, exec, ambxst brightness +5 -s"
      ", XF86MonBrightnessDown, exec, ambxst brightness -5 -s"
      ", XF86KbdBrightnessUp, exec, brightnessctl -d *::kbd_backlight set 5%+"
      ", XF86KbdBrightnessDown, exec, brightnessctl -d *::kbd_backlight set 5%-"
    ];

    application = [
      "SUPER, Return, exec, foot"
      "SUPER, W, exec, zen-beta"
      "SUPER, E, exec, handlr open ~"
      "SUPER, X, exec, codium"
    ];

    shell = [
      "SUPER, SUPER_L, exec, ambxst run dashboard"
      "SUPER, R, exec, ambxst run launcher"
      "SUPER, T, exec, ambxst run tmux"
      "SUPER, V, exec, ambxst run clipboard"
      "SUPER, TAB, exec, ambxst run overview"
      "SUPER, SLASH, exec, ambxst run assistant"
      "SUPER, APOSTROPHE, exec, ambxst run notes"

      "SUPER, PERIOD, exec, ambxst run emoji"
      "SUPER, SEMICOLON, exec, ambxst run tools"

      "SUPER, PRINT, exec, ambxst run screenshot"
      "SUPER SHIFT, PRINT, exec, ambxst run screenrecord"
      "SUPER ALT, PRINT, exec, ambxst run lens"

      "SUPER, COMMA, exec, ambxst run config"
      "SUPER ALT, COMMA, exec, ambxst run wallpapers"

      "SUPER, L, exec, ambxst lock"
      "SUPER, ESCAPE, exec, ambxst run powermenu"
    ];

    nix = [
      "SUPER ALT, R, exec, pkexec nixos-rebuild switch --flake ~/.config/nix"
      "SUPER ALT, DELETE, exec, pkexec nix-collect-garbage -d"
    ];
  in {
    bind = navigation ++ window ++ application ++ shell ++ nix;
    binde = window_E;
    bindle = specialKeys_LE;
    bindm = window_M;
  };
}
