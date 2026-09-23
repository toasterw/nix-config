{ pkgs, username, ... }:
{
  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = [
      pkgs.virtiofsd
    ];
  };
  programs.virt-manager.enable = true;

  users.users.${username}.extraGroups = [ "libvirtd" ];

  environment.systemPackages = [
    pkgs.dnsmasq
  ];

  networking.firewall.trustedInterfaces = [ "virbr0" ];

  # virtualisation.virtualbox.host.enable = true;
  # users.users.${username}.extraGroups = [ "vboxusers" ];
}
