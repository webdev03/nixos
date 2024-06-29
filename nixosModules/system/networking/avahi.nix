{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    system.avahi.enable = lib.mkEnableOption "Avahi";
  };

  config = {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;
    };
  };
}
