{...}: {
  flake.nixosModules.network = {...}: {
    networking = {
      networkmanager = {
        enable = true;
        wifi.backend = "wpa_supplicant";
      };

      nftables.enable = true;

      firewall = {
        enable = true;
      };
    };
    systemd.services.NetworkManager-wait-online.enable = false;
  };
}
