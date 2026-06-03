_: {
  imports = [
    ./asus.nix
    ./bootloader.nix
    ./graphics.nix
    ./sound.nix
    ./networking.nix
  ];

  time.timeZone = "Asia/Kolkata";

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.upower.enable = true;
}
