{
  lib,
  osConfig,
  config,
  pkgs,
  ...
}: {
  options.programs.ambxst = lib.mkOption {
    type = lib.types.submodule {
      options = {
        wallpaperDirectory = lib.mkOption {
          type = lib.types.path;
          default = ../wallpapers;
          description = "Path to wallpaper in the structure <wallpaperDirectory>/<selector>/image.<jpg/png/gif>";
        };
        wallpaperSelector = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Selector for wallpaper set";
          # TODO: Validate if the selector exists
        };
        configOverrides = lib.mkOption {
          type = lib.types.attrsOf (lib.types.attrsOf lib.types.anything);
          default = {};
          description = "Per-file JSON overrides for ambxst";
        };
      };
    };

    default = {};
  };

  config = let
    configPatchScript = let
      mkConfigPatch = file: attrs: ''
        FILE_PATH="$TARGET/${file}"

        if [ -f "$FILE_PATH" ]; then
          tmp=$(mktemp "$FILE_PATH.tmp.XXXX")

          PATCH='${builtins.toJSON attrs}'

          BEFORE=$(${pkgs.coreutils}/bin/sha256sum "$FILE_PATH" | cut -d ' ' -f1)

          ${pkgs.jq}/bin/jq --argjson patch "$PATCH" '. * $patch' "$FILE_PATH" > "$tmp"
          mv "$tmp" "$FILE_PATH"

          AFTER=$(${pkgs.coreutils}/bin/sha256sum "$FILE_PATH" | cut -d ' ' -f1)

          if [ "$BEFORE" != "$AFTER" ]; then
            CHANGED=1
          fi
        fi
      '';
    in
      pkgs.writeShellScript "ambxst-config-patch" ''
        set -euo pipefail

        TARGET="$HOME/.config/ambxst/config"
        [ -d "$TARGET" ] || exit 0

        CHANGED=0

        ${lib.concatStringsSep "\n" (lib.mapAttrsToList mkConfigPatch config.programs.ambxst.configOverrides)}

        if [ "$CHANGED" -eq 1 ]; then
          ${osConfig.programs.ambxst.package}/bin/ambxst reload || true
        fi
      '';

    setWallpaperScript = pkgs.writeShellScript "ambxst-set-wallpaper" ''
      set -euo pipefail

      WALLPAPER_CACHE="${config.xdg.cacheHome}/ambxst/wallpapers.json"
      [ -f "$WALLPAPER_CACHE" ] || exit 0

      CURRENT_WALL="$(${pkgs.findutils}/bin/find "${config.programs.ambxst.wallpaperDirectory}/${config.programs.ambxst.wallpaperSelector}" -type f | ${pkgs.coreutils}/bin/shuf -n 1)"
      [ -f "$CURRENT_WALL" ] || exit 0

      # Remove on fix: https://github.com/Axenide/Ambxst/issues/160
      OLD_PIDS=($(pgrep -f mpvpaper || true))
      OLD_PID_COUNT=''${#OLD_PIDS[@]}

      ${pkgs.jq}/bin/jq \
        --arg wallPath "${config.programs.ambxst.wallpaperDirectory}/${config.programs.ambxst.wallpaperSelector}" \
        --arg currentWall "$CURRENT_WALL" \
        '.wallPath = $wallPath | .currentWall = $currentWall' \
        "$WALLPAPER_CACHE" > "$WALLPAPER_CACHE.tmp" \
        && mv "$WALLPAPER_CACHE.tmp" "$WALLPAPER_CACHE"

      while [ "$(pgrep -f mpvpaper || echo 0)" -le "$OLD_PID_COUNT" ]; do
        sleep 0.5
      done

      sleep 2

      if [ $OLD_PID_COUNT -gt 0 ]; then
        kill "''${OLD_PIDS[@]}"
      fi
    '';
  in
    lib.mkIf (osConfig.programs.ambxst.enable or false) {
      systemd.user = {
        services.ambxst-config-patch = {
          Unit.Description = "Patch Ambxst configs";

          Service = {
            Type = "oneshot";
            ExecStart = configPatchScript;
          };

          Install.WantedBy = ["default.target"];
        };

        timers.ambxst-config-patch = {
          Unit.Description = "Timer for ambxst-config-patch";

          Timer = {
            OnBootSec = "30s";
            OnUnitActiveSec = "5min";
          };

          Install.WantedBy = ["timers.target"];
        };

        services.ambxst-set-wallpaper = {
          Unit.Description = "Set Ambxst wallpaper";

          Service = {
            Type = "oneshot";
            ExecStart = setWallpaperScript;
          };

          Install.WantedBy = ["default.target"];
        };

        timers.ambxst-set-wallpaper = {
          Unit.Description = "Timer for ambxst-set-wallpaper";

          Timer.OnUnitActiveSec = "1min";

          Install.WantedBy = ["timers.target"];
        };
      };
    };
}
