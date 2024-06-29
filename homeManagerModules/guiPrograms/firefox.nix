{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    guiPrograms.firefox.enable = lib.mkEnableOption "Firefox";
  };

  config = lib.mkIf config.guiPrograms.firefox.enable {
    programs.firefox = {
      enable = true;
      nativeMessagingHosts = [pkgs.plasma-browser-integration];
    };
  };
}
