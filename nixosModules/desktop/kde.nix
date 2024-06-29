{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    desktop.kde.enable = lib.mkEnableOption "KDE Plasma 6";
  };
  config = lib.mkIf config.desktop.kde.enable {
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    services.desktopManager.plasma6.enable = true;
  };
}
