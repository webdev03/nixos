{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    cliPrograms.alejandra.enable = lib.mkEnableOption "alejandra (nix formatter)";
  };

  config = lib.mkIf config.cliPrograms.alejandra.enable {
    home.packages = [pkgs.alejandra];
  };
}
