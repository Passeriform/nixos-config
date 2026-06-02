self: super: {
  vscodium = super.vscodium.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [super.jq super.unixtools.xxd];

    postInstall = let
      searchPattern = "async run(s){const n=s.get(nt),";
      replacePattern = "async run(s,t){const n=s.get(nt);if(typeof t===\\\"string\\\"){const p=e.userDataProfilesService.profiles.find(x=>x.name===t.trim());if(p){const svc=Object.values(e).find(v=>v?.switchProfile);if(svc)return svc.switchProfile(p);}}const ";
    in
      (oldAttrs.postInstall or "")
      + ''
        echo "Patching VSCodium SwitchProfileAction to support programmatic string names..."

        MAIN_JS=$(find $out -type f -name "workbench.desktop.main.js" | head -n 1)

        chmod +w "$MAIN_JS"

        echo "Found MAIN_JS at $'{MAIN_JS}"

        sed -i 's/${searchPattern}/${replacePattern}/g' "$MAIN_JS"

        PRODUCT_JSON=$(find $out -type f -name "product.json" | head -n 1)

        chmod +w "$PRODUCT_JSON"

        NEW_HASH=$(sha256sum "$MAIN_JS" | cut -d' ' -f1 | xxd -r -p | base64 | tr -d '=')

        echo "Calculated New Checksum for workbench.desktop.main.js: $NEW_HASH"

        echo "Updating product.json"

        TARGET_KEY="vs/workbench/workbench.desktop.main.js"

        jq --arg key "$TARGET_KEY" --arg hash "$NEW_HASH" \
          '.checksums[$key] = $hash' "$PRODUCT_JSON" > "$PRODUCT_JSON.tmp"

        mv "$PRODUCT_JSON.tmp" "$PRODUCT_JSON"

        echo "Updated checksums with new hash after patching"

        echo "Restoring permissions"

        chmod -w "$MAIN_JS"
        chmod -w "$PRODUCT_JSON"

        echo "Patch successfully applied."
      '';
  });
}
