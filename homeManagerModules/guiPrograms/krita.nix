{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    guiPrograms.krita.enable = lib.mkEnableOption "Krita";
  };

  config = lib.mkIf config.guiPrograms.krita.enable {
    home.packages = [pkgs.krita];
  };
}
