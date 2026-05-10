{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [vscodium];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles = {
      default = {
        extensions =
          (with pkgs.vscode-extensions; [
            mikestead.dotenv
            editorconfig.editorconfig
            streetsidesoftware.code-spell-checker
            wix.vscode-import-cost
            gruntfuggly.todo-tree
            redhat.vscode-yaml
            mkhl.direnv
          ])
          ++ (with inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace; [
            pixl-garden.bongocat
          ])
          ++ (with inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.open-vsx; [
            azir-11.azir-vscode-theme
          ]);

        userSettings = {
          "chat.fontFamily" = "'Iosevka Nerd Font', 'FiraCode Nerd Font'";
          "chat.editor.fontFamily" = "'Iosevka Nerd Font', 'FiraCode Nerd Font'";
          "debug.console.fontFamily" = "'Iosevka Nerd Font', 'FiraCode Nerd Font'";
          "debug.hideSlowPreLaunchWarning" = true;
          "editor.codeLensFontFamily" = "'Iosevka Nerd Font', 'FiraCode Nerd Font'";
          "editor.cursorBlinking" = "phase";
          "editor.cursorSmoothCaretAnimation" = "on";
          "editor.cursorStyle" = "block";
          "editor.fontFamily" = "'Iosevka Nerd Font', 'FiraCode Nerd Font'";
          "editor.fontLigatures" = true;
          "editor.inlayHints.fontFamily" = "'Iosevka Nerd Font', 'FiraCode Nerd Font'";
          "editor.inlineSuggest.fontFamily" = "'Iosevka Nerd Font', 'FiraCode Nerd Font'";
          "editor.smoothScrolling" = true;
          "explorer.confirmDelete" = false;
          "explorer.confirmDragAndDrop" = false;
          "explorer.confirmPasteNative" = false;
          "files.simpleDialog.enable" = true;
          "git.autofetch" = true;
          "git.confirmSync" = false;
          "markdown.preview.fontFamily" = "'Iosevka Nerd Font', 'FiraCode Nerd Font'";
          "notebook.markup.fontFamily" = "'Iosevka Nerd Font', 'FiraCode Nerd Font'";
          "notebook.output.fontFamily" = "'Iosevka Nerd Font', 'FiraCode Nerd Font'";
          "scm.inputFontFamily" = "'Iosevka Nerd Font', 'FiraCode Nerd Font'";
          "terminal.integrated.cursorBlinking" = true;
          "terminal.integrated.enableMultiLinePasteWarning" = "never";
          "terminal.integrated.fontFamily" = "'Iosevka Nerd Font', 'FiraCode Nerd Font'";
          "terminal.integrated.fontLigatures.enabled" = true;
          "terminal.integrated.scrollback" = 100000;
          "terminal.integrated.smoothScrolling" = true;
          "window.titleBarStyle" = "native";
          "window.customTitleBarVisibility" = "never";
          "window.menuBarVisibility" = "hidden";
          "workbench.colorTheme" = "Azir Buddha Vira Carbon";
          "workbench.layoutControl.enabled" = false;
          "workbench.list.smoothScrolling" = true;
          "workbench.productIconTheme" = "bongocat";
          "workbench.startupEditor" = "none";
          "workbench.welcomePage.extraAnnouncements" = false;
          "workbench.welcomePage.walkthroughs.openOnInstall" = false;
        };
      };
    };
  };
}
