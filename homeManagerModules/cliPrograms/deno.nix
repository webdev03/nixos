{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    cliPrograms.deno.enable = lib.mkEnableOption "Deno";
  };

  config = lib.mkIf config.cliPrograms.deno.enable {
    home.packages = [pkgs.deno];
  };
}
