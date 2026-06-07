_: super: {
  yazi =
    super.runCommand "yazi-xdg" {
      buildInputs = [super.yazi-unwrapped];
    } ''
      cp -r ${super.yazi-unwrapped} $out

      chmod -R u+w $out

      substituteInPlace $out/share/applications/yazi.desktop \
        --replace-fail "Exec=yazi %f" "Exec=foot -e yazi %f" \
        --replace-fail "Terminal=true" "Terminal=false"
    '';
}
