{pkgs, ...}: let
  desktopEntryName = "local.qbittorrent";

  handle-torrent = pkgs.writeShellScript "torrent-handler" ''
    if [[ "$1" =~ ^magnet: ]]; then
      ${pkgs.curl}/bin/curl -X POST "http://localhost:8080/download?url=$1"
    else
      ${pkgs.curl}/bin/curl -X POST -F "file=@$1" "http://localhost:8080/download"
    fi
  '';

  qbittorrent-protocol-handler = pkgs.makeDesktopItem {
    name = desktopEntryName;
    desktopName = "Qbittorrent Web UI Protocol Handler";
    exec = "${handle-torrent} %u";
    mimeTypes = ["x-scheme-handler/magnet" "application/x-bittorrent"];
    noDisplay = true;
  };
in {
  home.packages = [qbittorrent-protocol-handler];
}
