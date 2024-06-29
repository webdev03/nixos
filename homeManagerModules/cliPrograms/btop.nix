{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    cliPrograms.btop.enable = lib.mkEnableOption "btop";
  };

  config = lib.mkIf config.cliPrograms.btop.enable {
    programs.btop = {
      enable = true;
    };
  };
}
