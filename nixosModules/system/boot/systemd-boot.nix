{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    system.systemd-boot.enable = lib.mkEnableOption "systemd-boot bootloader";
  };

  config = lib.mkIf config.system.systemd-boot.enable {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
