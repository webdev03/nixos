{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    guiPrograms.kicad.enable = lib.mkEnableOption "KiCAD";
  };

  config = lib.mkIf config.guiPrograms.kicad.enable {
    home.packages = [pkgs.kicad-small];
  };
}
