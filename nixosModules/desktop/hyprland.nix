{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    desktop.hyprland.enable = lib.mkEnableOption "Hyprland and friends";
  };
  config = lib.mkIf config.desktop.hyprland.enable {
    services.xserver.enable = true;
    services.xserver.displayManager.startx.enable = true;
    # services.displayManager.sddm.enable = true;
    # services.displayManager.sddm.wayland.enable = true;
    programs.hyprland.enable = true;

    services.gnome.gnome-keyring.enable = true;
    security.pam.services.sddm.enableGnomeKeyring = true;

    security.pam.services.hyprlock = {};
    
    services.gvfs.enable = true;
  };
}
