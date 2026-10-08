{ pkgs, inputs, ... }:
let
  wings = inputs.wings.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  virtualisation.docker.enable = true;

  environment.systemPackages = [ wings ];

  networking.firewall = {
    allowedTCPPorts = [
      8080
      2022
    ];
  };

  systemd.services.wings = {
    enable = true;
    description = "Pterodactyl Wings daemon";
    after = [ "docker.service" ];
    partOf = [ "docker.service" ];
    requires = [ "docker.service" ];
    startLimitIntervalSec = 180;
    startLimitBurst = 30;
    serviceConfig = {
      User = "root";
      WorkingDirectory = "/etc/pterodactyl";
      LimitNOFILE = 4096;
      PIDFile = "/var/run/wings/daemon.pid";
      ExecStart = "${wings}/bin/wings";
      Restart = "on-failure";
      RestartSec = "5s";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
