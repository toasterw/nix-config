{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.nixos-hardware = {
    config,
    lib,
    pkgs,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [
      "nvme"
      "xhci_pci_prom21"
      "ahci"
      "xhci_pci"
      "thunderbolt"
      "usbhid"
    ];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-amd"];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/eb1099d2-91b7-4c88-a8ea-3847dc670b8c";
      fsType = "btrfs";
      options = ["subvol=root"];
    };

    fileSystems."/home" = {
      device = "/dev/disk/by-uuid/eb1099d2-91b7-4c88-a8ea-3847dc670b8c";
      fsType = "btrfs";
      options = ["subvol=home"];
    };

    fileSystems."/nix" = {
      device = "/dev/disk/by-uuid/eb1099d2-91b7-4c88-a8ea-3847dc670b8c";
      fsType = "btrfs";
      options = ["subvol=nix"];
    };

    fileSystems."/swap" = {
      device = "/dev/disk/by-uuid/eb1099d2-91b7-4c88-a8ea-3847dc670b8c";
      fsType = "btrfs";
      options = ["subvol=swap"];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/827C-B623";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    fileSystems."/mnt/games" = {
      device = "/dev/disk/by-uuid/ea01290c-b53c-d7ad-c379-393369f4464f";
      fsType = "btrfs";
    };

    fileSystems."/mnt/NAS" = {
      device = "192.168.0.10:/mnt/NAS/Storage";
      fsType = "nfs4";
    };

    fileSystems."/mnt/Jellyfin" = {
      device = "192.168.0.10:/mnt/NAS/Jellyfin";
      fsType = "nfs4";
    };

    swapDevices = [];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
