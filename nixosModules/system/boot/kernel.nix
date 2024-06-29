{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    system.kernel.useLatestKernel = lib.mkEnableOption "the latest kernel";
  };

  config = lib.mkIf config.system.kernel.useLatestKernel {
    boot.kernelPackages = pkgs.linuxPackages_latest;
  };
}
