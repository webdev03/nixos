{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    guiPrograms.obs-studio.enable = lib.mkEnableOption "OBS Studio";
  };

  config = lib.mkIf config.guiPrograms.obs-studio.enable {
    programs.obs-studio = {
      enable = true;
    };
  };
}
