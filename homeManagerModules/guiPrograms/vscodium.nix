{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    guiPrograms.vscodium.enable = lib.mkEnableOption "VSCodium";
  };

  config = lib.mkIf config.guiPrograms.vscodium.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
    };
  };
}
