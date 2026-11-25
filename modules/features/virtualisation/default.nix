{
  flake.nixosModules.virtualisation = {
    pkgs,
    config,
    ...
  }: {
    virtualisation.libvirtd = {
      enable = true;
      qemu.vhostUserPackages = [
        pkgs.virtiofsd
      ];
    };

    programs.virt-manager.enable = true;

    users.users.${config.user.name}.extraGroups = ["libvirtd"];

    environment.systemPackages = [
      pkgs.dnsmasq
    ];

    networking.firewall.trustedInterfaces = ["virbr0"];

    # virtualisation.virtualbox.host.enable = true;
    # users.users.${config.user.name}.extraGroups = ["vboxusers"];
  };
}
