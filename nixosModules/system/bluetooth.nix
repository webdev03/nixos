{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    system.bluetooth.enable = lib.mkEnableOption "bluetooth";
    system.bluetooth.powerOnBoot = lib.mkEnableOption "bluetooth on boot";
  };

  config = {
    hardware.bluetooth.enable = config.system.bluetooth.enable;
    hardware.bluetooth.powerOnBoot = config.system.bluetooth.powerOnBoot;
  };
}
