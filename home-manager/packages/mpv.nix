{pkgs, ...}: {
  programs.mpv = {
    enable = true;

    scripts = with pkgs.mpvScripts; [
      axosc
      mpv-notify-send
      thumbfast
      sponsorblock
      mpris
    ];

    config = {
      border = "no";
      cache = "yes";
      demuxer-max-back-bytes = "100MiB";
      demuxer-max-bytes = "500MiB";
      force-window = "yes";
      gpu-context = "wayland";
      hwdec = "auto-safe";
      osc = "no";
      osd-bar = "no";
      profile = "gpu-hq";
      vo = "gpu-next";
      window-dragging = "no";
      ytdl-format = "bestvideo[height<=?1080]+bestaudio/best";
    };
  };
}
