_: let
  mounts = ["Dev" "Dump" "BigStore"];
in {
  fileSystems = builtins.listToAttrs (map (name: {
      name = "/run/media/${name}";
      value = {
        label = name;
        fsType = "ntfs";
        options = [
          "auto"
          "default"
          "nouser"
          "nofail"
          "nodev"
          "exec"
          "uid=1000"
          "gid=100"
          "fmask=0133"
          "dmask=0022"
          "x-gvfs-show"
        ];
      };
    })
    mounts);
}
