final: prev: let
  shimScript = final.writeShellScript "xdg-open" ''
    exec ${final.handlr-regex}/bin/handlr open "$@"
  '';
in {
  xdg-utils = prev.xdg-utils.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [final.makeWrapper];
    postFixup =
      (oldAttrs.postFixup or "")
      + ''
        rm -f $out/bin/xdg-open
        ln -sf ${shimScript} $out/bin/xdg-open
      '';
  });
}
