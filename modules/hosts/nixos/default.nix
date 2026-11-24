{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      nixos-configuration
      nixos-filesystems
      nixos-hardware

      audio
      bluetooth
      docker
      fonts
      limine
      locale
      network
      nh
      nix
      nvidia
      openssh
      user

      coolercontrol
      discord
      gaming
      git
      gpg
      helium
      ios
      kde
      kitty
      kopuz
      librepods
      ly
      nvidia-vaapi-driver
      obs
      openrgb
      printing
      sunshine
      tailscale
      virtualisation
      wings
      zed
      zsh

      apps
      cli
      dev
      media
    ];
  };
}
