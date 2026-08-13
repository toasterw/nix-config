{ config, ... }:
{
  services.tailscale.enable = true;
  networking.firewall = {
    trustedInterfaces = [ config.services.tailscale.interfaceName ];
    allowedUDPPorts = [ config.services.tailscale.port ];
  };

  services.tailscale.useRoutingFeatures = "server";

  systemd.services.tailscaled.serviceConfig.Environment = [
      "TS_DEBUG_FIREWALL_MODE=nftables"
    ];
}
