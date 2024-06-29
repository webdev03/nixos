{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    cliPrograms.bun.enable = lib.mkEnableOption "Bun";
  };

  config = lib.mkIf config.cliPrograms.bun.enable {
    programs.bun = {
      enable = true;
    };
  };
}
