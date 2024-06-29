{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    cliPrograms.hyperfine.enable = lib.mkEnableOption "hyperfine";
  };

  config = lib.mkIf config.cliPrograms.hyperfine.enable {
    home.packages = [pkgs.hyperfine];
  };
}
