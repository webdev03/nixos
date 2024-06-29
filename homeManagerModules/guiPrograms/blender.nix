{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    guiPrograms.blender.enable = lib.mkEnableOption "Blender";
  };

  config = lib.mkIf config.guiPrograms.blender.enable {
    home.packages = [pkgs.blender];
  };
}
