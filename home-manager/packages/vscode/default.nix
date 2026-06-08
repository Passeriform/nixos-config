{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  commonExtensions =
    (with pkgs.vscode-extensions; [
      streetsidesoftware.code-spell-checker
      gruntfuggly.todo-tree
      redhat.vscode-yaml
      mkhl.direnv
      jnoortheen.nix-ide
      kamadorueda.alejandra
    ])
    ++ (with inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace; [
      pixl-garden.bongocat
      passeriform.direnv-vscode-profile
    ])
    ++ (with inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.open-vsx; [
      azir-11.azir-vscode-theme
    ]);

  nixSettings = builtins.fromJSON (builtins.readFile ./settings/nix.json);

  webExtensions =
    (with pkgs.vscode-extensions; [
      mikestead.dotenv
      editorconfig.editorconfig
      wix.vscode-import-cost
      yoavbls.pretty-ts-errors
    ])
    ++ (with inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.open-vsx; [
      antfu.vite
      oxc.oxc-vscode
      vitest.explorer
    ]);

  userSettings = builtins.fromJSON (builtins.readFile ./settings/user.json);

  mergeSettings = builtins.foldl' lib.recursiveUpdate {};
in {
  home.packages = with pkgs; [vscodium];

  programs.vscodium = {
    enable = true;
    profiles = {
      default = {
        inherit userSettings;
        extensions = commonExtensions;
      };
      nix = {
        userSettings = mergeSettings [userSettings nixSettings];
        extensions = commonExtensions;
      };
      web = {
        inherit userSettings;
        extensions = commonExtensions ++ webExtensions;
      };
    };
  };

  xdg.mimeApps = let
    associations =
      builtins.listToAttrs (map (mime: {
        name = mime;
        value = "codium.desktop";
      }) ["text/xml" "text/html" "text/plain" "text/javascript" "application/json"])
      // builtins.listToAttrs (map (mime: {
        name = mime;
        value = "codium-url-handler.desktop";
      }) ["x-scheme-handler/vscode" "x-scheme-handler/vscodium"]);
  in
    lib.mkIf config.xdg.mimeApps.enable {
      defaultApplicationPackages = with pkgs; [vscodium];
      associations.added = associations;
      defaultApplications = associations;
    };
}
