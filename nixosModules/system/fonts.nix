{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    system.fonts.enable = lib.mkEnableOption "fonts";
  };

  config = lib.mkIf config.system.fonts.enable {
    fonts.packages = [
      (pkgs.nerdfonts.override {fonts = ["JetBrainsMono" "IntelOneMono"];})
    ];
  };
}
