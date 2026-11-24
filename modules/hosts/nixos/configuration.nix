{
  flake.nixosModules.nixos-configuration = {
    pkgs,
    lib,
    config,
    ...
  }: {
    user.name = "toaster";

    boot.loader.limine.extraEntries = ''
      /Windows
        protocol: efi
        path: uuid(92cc8a94-0fec-457b-b74c-434bb67e0f0f):/EFI/Microsoft/Boot/bootmgfw.efi
    '';

    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.kernelParams = [
      "acpi_enforce_resources=lax" # fix resource loading conflict with it87
      "drm.edid_firmware=DP-2:edid/virtual-display.bin"
      "video=DP-2:e"
    ];

    boot.blacklistedKernelModules = ["k10temp"];
    boot.kernelModules = [
      "zenpower"
      "it87"
    ];
    boot.extraModulePackages = with config.boot.kernelPackages; [
      zenpower
      it87
    ];
    boot.extraModprobeConfig = ''
      options it87 force_id=0x8696
    '';

    hardware.firmware = [
      (pkgs.runCommand "virtual-display.bin" {} ''
        mkdir -p $out/lib/firmware/edid
        cp ${./virtual-display.bin} $out/lib/firmware/edid/virtual-display.bin
      '')
    ];

    hardware.wooting.enable = true;

    # Generic Razer Devices (Synapse Web)
    services.udev.extraRules = ''
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1532", MODE:="0660", GROUP="input" TAG+="uaccess"
      SUBSYSTEM=="usb", ATTRS{idVendor}=="1532", MODE:="0660", GROUP="input", TAG+="uaccess"
    '';

    environment.etc."libinput/local-overrides.quirks".text = lib.mkForce ''
      [Glorious Model O Wireless]
      MatchName=Glorious Model O Wireless
      ModelBouncingKeys=1
    '';

    powerManagement.cpuFreqGovernor = "performance";
  };
}
