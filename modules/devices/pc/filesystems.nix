{
  boot.supportedFilesystems = ["nfs"];

  fileSystems = {
    "/".options = ["compress=zstd"];
    "/home".options = ["compress=zstd"];
    "/nix".options = [
      "compress=zstd"
      "noatime"
    ];
    "/swap".options = ["noatime"];
    "/mnt/games".options = [
      "users"
      "nofail"
      "exec"
    ];
    "/mnt/Jellyfin".options = [
      "x-systemd.automount"
      "noauto"
    ];
    "/mnt/NAS".options = [
      "x-systemd.automount"
      "noauto"
    ];
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = ["/"];
  };

  boot.zswap = {
    enable = true;
    maxPoolPercent = 25;
    shrinkerEnabled = true;
    compressor = "zstd";
    acceptThresholdPercent = 90;
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      options = ["discard"];
      size = 16 * 1024; # 16GiB swap file
      randomEncryption = {
        enable = true;
        allowDiscards = true;
      };
    }
  ];
}
