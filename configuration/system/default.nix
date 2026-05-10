_: {
  imports = [
    ./bootloader.nix
    ./graphics.nix
    ./sound.nix
    ./keyboard.nix
    ./networking.nix
  ];

  time.timeZone = "Asia/Kolkata";

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.upower.enable = true;
}
