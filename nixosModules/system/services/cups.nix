{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    system.printing.enable = lib.mkEnableOption "CUPS printing";
  };
  config = {
    services.printing.enable = config.system.printing.enable;
  };
}
