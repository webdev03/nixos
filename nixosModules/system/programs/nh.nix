{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    system.nh.enable = lib.mkEnableOption "nh";
  };

  config = lib.mkIf config.system.nh.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 3d --keep 5";
      flake = "/home/devarsh/nixos";
    };
  };
}
