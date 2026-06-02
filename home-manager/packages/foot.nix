{pkgs, ...}: {
  home.packages = with pkgs; [
    foot
    yazi
  ];

  programs.foot = {
    enable = true;
    settings = {
      colors-dark.background = "0a0a0a";
      main = {
        font = "Iosevka Nerd Font:size=11";
        pad = "20x10";
      };
    };
  };
}
