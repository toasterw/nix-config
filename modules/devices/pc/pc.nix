{
  pkgs,
  config,
  ...
}:

{
  boot.loader.limine = {
    enable = true;
    secureBoot = {
      enable = true;
    };
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
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 16 * 1024; # 16GiB swap file
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

  services.printing = {
    enable = true;
    drivers = [
      pkgs.cnijfilter2
    ];
  };

  environment.etc."libinput/local-overrides.quirks".text = pkgs.lib.mkForce ''
    [Glorious Model O Wireless]
    MatchName=Glorious Model O Wireless
    ModelBouncingKeys=1
  '';

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 25565 ];
    allowedUDPPorts = [
      8800
      25565
    ];
  };

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
    package = pkgs.sunshine.override {
      cudaSupport = true;
      cudaPackages = pkgs.cudaPackages;
    };
  };

  services.udev.extraRules = ''
    KERNEL=="uhid", SUBSYSTEM=="misc", GROUP="uinput", MODE="0660"
  '';

  services.hardware.openrgb.enable = true;

  powerManagement.cpuFreqGovernor = "performance";
}
