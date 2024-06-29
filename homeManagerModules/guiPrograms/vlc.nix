{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    guiPrograms.vlc.enable = lib.mkEnableOption "VLC Media Player";
  };

  config = lib.mkIf config.guiPrograms.vlc.enable {
    home.packages = [pkgs.vlc];
  };
}
