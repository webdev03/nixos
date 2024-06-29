{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    cliPrograms.git.enable = lib.mkEnableOption "Git";
    cliPrograms.git.gh.enable = lib.mkEnableOption "GitHub CLI";
  };

  config = {
    home.packages =
      (
        if config.cliPrograms.git.enable
        then [pkgs.git]
        else []
      )
      ++ (
        if config.cliPrograms.git.gh.enable
        then [pkgs.gh]
        else []
      );
  };
}
