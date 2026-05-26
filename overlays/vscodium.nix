self: super: {
  vscodium = super.vscodium.overrideAttrs (oldAttrs: {
    postInstall = let
      searchPattern = "async run(s){const n=s.get(Je),";
      replacePattern = "async run(s,t){const n=s.get(Je);if(typeof t===\\\"string\\\"){const p=e.userDataProfilesService.profiles.find(x=>x.name===t.trim());if(p){const svc=Object.values(e).find(v=>v?.switchProfile);if(svc)return svc.switchProfile(p);}}const ";
    in
      (oldAttrs.postInstall or "")
      + ''
        echo "Patching VSCodium SwitchProfileAction to support programmatic string names..."

        MAIN_JS=$(find $out -type f -name "workbench.desktop.main.js" | head -n 1)
        chmod +w "$MAIN_JS"

        echo "Found MAIN_JS at $'{MAIN_JS}"

        sed -i 's/${searchPattern}/${replacePattern}/g' "$MAIN_JS"

        echo "Patch successfully applied."
      '';
  });
}
