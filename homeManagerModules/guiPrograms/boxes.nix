{
  pkgs,
  lib,
  config,
  ...
}: {
  # system.virtualisation.enable must be on in the NixOS config!!
  options = {
    guiPrograms.boxes.enable = lib.mkEnableOption "GNOME Boxes";
  };

  config = lib.mkIf config.guiPrograms.boxes.enable {
    home.packages = [pkgs.gnome-boxes];
  };
}
