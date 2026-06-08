final: prev: {
  yazi =
    final.runCommand "yazi-xdg" {
      buildInputs = [prev.yazi-unwrapped];
    } ''
      cp -r ${prev.yazi-unwrapped} $out

      chmod -R u+w $out

      substituteInPlace $out/share/applications/yazi.desktop \
        --replace-fail "Exec=yazi %f" "Exec=foot -e yazi %f" \
        --replace-fail "Terminal=true" "Terminal=false"
    '';
}
