{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    cliPrograms.tree.enable = lib.mkEnableOption "tree";
  };

  config = lib.mkIf config.cliPrograms.tree.enable {
    home.packages = [pkgs.tree];
  };
}
