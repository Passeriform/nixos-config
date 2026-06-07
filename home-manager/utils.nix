{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-index-database.homeModules.default
  ];

  home.packages = with pkgs; [
    # Archive
    zip
    unzip

    # Networking
    dnsutils
    iputils
    unixtools.net-tools
    wget

    # Nix
    handlr-regex
    nix-melt
    nix-tree

    # Utils
    acpica-tools
    fastfetch
    file
    htop
    lsof
    tree
    unixtools.util-linux
    unixtools.procps
    yq-go
  ];

  programs = {
    fastfetch.enable = true;
    nix-index-database.comma.enable = true;
    pay-respects.enable = true;
    ripgrep.enable = true;
    asciinema.enable = true;
    jq.enable = true;
    fzf.enable = true;
    zoxide.enable = true;
  };
}
