{ ... }:

{
  services.displayManager.ly = {
    enable = true;
    settings = {
      load = false;
      save = false;
    };
  };

  services.displayManager.defaultSession = "plasma";

  # services.displayManager.autoLogin = {
  #   enable = true;
  #   user = "toaster";
  # };
}
