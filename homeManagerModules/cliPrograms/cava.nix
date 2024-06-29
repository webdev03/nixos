{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    cliPrograms.cava.enable = lib.mkEnableOption "cava (audio visualiser)";
  };

  config = lib.mkIf config.cliPrograms.cava.enable {
    programs.cava = {
      enable = true;
      settings = {
        general = {
          mode = "normal";
          framerate = 60;
          autosens = 1;
        };
        input.method = "pipewire";
        output = {
          method = "ncurses";
          style = "mono";
        };
        color = {
          background = "'#EFF1F5'";
          foreground = "'#04A5E5'";
        };
      };
    };
  };
}
