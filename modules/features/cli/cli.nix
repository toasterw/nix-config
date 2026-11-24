{
  flake.nixosModules.cli = {
    pkgs,
    lib,
    config,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      (
        if lib.elem "nvidia" config.services.xserver.videoDrivers
        then btop-cuda
        else btop
      )
      bubblewrap
      fastfetch
      fzf
      unzip
      zip
    ];
  };
}
