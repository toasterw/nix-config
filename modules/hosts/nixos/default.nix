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
      fonts
      limine
      locale
      network
      nh
      nix
      nvidia
      openssh
      user

      apps
      cli
      dev

      coolercontrol
      discord
      gaming
      git
      gpg
      helium
      kde
      kitty
      kopuz
      ly
      nvidia-vaapi-driver
      obs
      sunshine
      zed
      zsh
    ];
  };
}
