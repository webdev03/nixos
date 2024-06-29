{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    system.plymouth.enable = lib.mkEnableOption "Plymouth boot splash screen";
  };

  config = lib.mkIf config.system.plymouth.enable {
    boot.plymouth = {
      enable = true;
      theme = "hexagon";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = ["hexagon"];
        })
      ];
    };

    boot.consoleLogLevel = 0;
    boot.initrd.verbose = false;
    boot.kernelParams = ["quiet" "splash" "boot.shell_on_fail" "loglevel=3" "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3"];
    boot.loader.timeout = lib.mkDefault 0;
  };
}
