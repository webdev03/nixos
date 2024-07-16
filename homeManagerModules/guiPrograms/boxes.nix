{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    guiPrograms.boxes.enable = lib.mkEnableOption "GNOME Boxes";
  };

  config = lib.mkIf config.guiPrograms.boxes.enable {
    home.packages = [pkgs.gnome.gnome-boxes];
  };
}
