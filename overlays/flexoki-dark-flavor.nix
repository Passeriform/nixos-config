final: _: {
  yaziFlavors.flexoki-dark = final.stdenvNoCC.mkDerivation (_: {
    pname = "flexoki-dark-flavor";
    version = "main";

    src = final.fetchFromGitHub {
      owner = "gosxrgxx";
      repo = "flexoki-dark.yazi";
      rev = "main";
      hash = "sha256-z8USdFAWqDl+8+aM83Hy0Wjjkdq62LC5PwcVpDMOWWY=";
    };

    installPhase = ''
      mkdir -p $out
      mv * $out/
    '';

    meta = {
      description = "Flexoki Dark Flavor for Yazi";
      homepage = "https://github.com/gosxrgxx/flexoki-dark.yazi";
      license = final.lib.licenses.mit;
      platforms = final.lib.platforms.linux;
      maintainers = with final.lib.maintainers; [passeriform];
    };
  });
}
