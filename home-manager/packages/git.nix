{pkgs, ...}: {
  home.packages = with pkgs; [gh];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Passeriform";
        email = "bhardwajutkarsh.ub@gmail.com";
      };
      init.defaultBranch = "master";
      push.autoSetupRemote = true;
    };
  };
}
