{
  pkgs,
  inputs,
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

  nixExtensions = with pkgs.vscode-extensions; [];

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

  userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
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
        inherit userSettings;
        extensions = commonExtensions ++ nixExtensions;
      };
      web = {
        inherit userSettings;
        extensions = commonExtensions ++ webExtensions;
      };
    };
  };
}
