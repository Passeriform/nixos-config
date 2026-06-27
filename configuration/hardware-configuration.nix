{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  boot = {
    kernelModules = ["kvm-amd"];
    kernelParams = ["mem_sleep_default=deep"];
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/a0e733bd-c618-4189-9931-4b9e4a32362c";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/8481-5D68";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/7cbbe9ea-4371-4de8-8744-42275868ce38";}
  ];

  boot.resumeDevice = "/dev/disk/by-uuid/7cbbe9ea-4371-4de8-8744-42275868ce38";
}
