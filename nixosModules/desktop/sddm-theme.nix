{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    desktop.sddm-theme.enable = lib.mkEnableOption "Catppuccin SDDM theme";
  };
  config = lib.mkIf config.desktop.sddm-theme.enable {
    assertions = [
      {
        assertion = config.services.displayManager.sddm.enable;
        message = "an sddm theme cannot be applied without sddm being installed";
      }
    ];
    environment.systemPackages = [
      (
        pkgs.catppuccin-sddm.override {
          flavor = "latte";
          font = "Noto Sans";
          fontSize = "9";
          background = "${../../homeManagerModules/desktop/wallpapers/nixos-blue.jpg}";
          loginBackground = true;
        }
      )
    ];
    services.displayManager.sddm = {
      package = pkgs.kdePackages.sddm;
      theme = "catppuccin-latte";
    };
  };
}
