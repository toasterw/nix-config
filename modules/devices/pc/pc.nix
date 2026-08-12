{
  pkgs,
  config,
  ...
}:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/ea01290c-b53c-d7ad-c379-393369f4464f";
    fsType = "btrfs";
    options = [
      "users"
      "nofail"
      "exec"
    ];
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;
  # fix resource loading conflict with it87
  boot.kernelParams = [
    "acpi_enforce_resources=lax"
    "drm.edid_firmware=DP-2:edid/virtual-display.bin"
    "video=DP-2:e"
  ];

  boot.blacklistedKernelModules = [ "k10temp" ];
  boot.kernelModules = [ "zenpower" "it87" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    zenpower5
    it87
  ];
  boot.extraModprobeConfig = ''
      options it87 force_id=0x8696
    '';

  hardware.firmware = [
  (
    pkgs.runCommand "virtual-display.bin" { } ''
      mkdir -p $out/lib/firmware/edid
      cp ${../../../resources/virtual-display.bin} $out/lib/firmware/edid/virtual-display.bin
    ''
  )];

  hardware.wooting.enable = true;

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

  services.hardware.openrgb.enable = true;

  powerManagement.cpuFreqGovernor = "performance";
}
