{
  device,
  username,
  ...
}: {
  imports =
    [
      ./pkgs.nix
    ]
    ++ (
      if device == "nixos"
      then [
        ./configuration.nix
      ]
      else []
    );
  home-manager.users.${username}.imports =
    []
    ++ (
      if device != "macbook"
      then [./home.nix]
      else []
    );

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
