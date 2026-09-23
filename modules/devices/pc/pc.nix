{
  pkgs,
  config,
  username,
  ...
}:

{
  boot.loader.limine = {
    enable = true;
    secureBoot = {
      enable = true;
    };
    extraEntries = ''
      /Windows
        protocol: efi
        path: uuid(92cc8a94-0fec-457b-b74c-434bb67e0f0f):/EFI/Microsoft/Boot/bootmgfw.efi
    '';
  };

  boot.loader.efi.canTouchEfiVariables = true;

  environment.systemPackages = [
    pkgs.sbctl
  ];

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [
      "compress=zstd"
      "noatime"
    ];
    "/swap".options = [ "noatime" ];
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
    fileSystems = [ "/" ];
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
      options = [ "discard" ];
      size = 16 * 1024; # 16GiB swap file
      randomEncryption = {
        enable = true;
        allowDiscards = true;
      };
    }
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [
    "acpi_enforce_resources=lax" # fix resource loading conflict with it87
    "drm.edid_firmware=DP-2:edid/virtual-display.bin"
    "video=DP-2:e"
  ];

  boot.blacklistedKernelModules = [ "k10temp" ];
  boot.kernelModules = [
    "zenpower"
    "it87"
  ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    zenpower5
    it87
  ];
  boot.extraModprobeConfig = ''
    options it87 force_id=0x8696
  '';

  hardware.firmware = [
    (pkgs.runCommand "virtual-display.bin" { } ''
      mkdir -p $out/lib/firmware/edid
      cp ${../../../resources/virtual-display.bin} $out/lib/firmware/edid/virtual-display.bin
    '')
  ];

  hardware.wooting.enable = true;

  # Generic Razer Devices (Synapse Web)
  services.udev.extraRules = ''
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1532", MODE:="0660", GROUP="input" TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1532", MODE:="0660", GROUP="input", TAG+="uaccess"
  '';

  environment.etc."libinput/local-overrides.quirks".text = pkgs.lib.mkForce ''
    [Glorious Model O Wireless]
    MatchName=Glorious Model O Wireless
    ModelBouncingKeys=1
  '';

  services.printing = {
    enable = true;
    drivers = [
      pkgs.cnijfilter2
    ];
  };

  hardware.sane.enable = true;

  users.users.${username}.extraGroups = [
    "scanner"
    "lp"
  ];

  services.hardware.openrgb.enable = true;

  powerManagement.cpuFreqGovernor = "performance";
}
