{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    system.virtualisation.enable = lib.mkEnableOption "Virtualisation";
  };
  config = lib.mkIf config.system.virtualisation.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [
            (pkgs.OVMF.override {
              secureBoot = true;
              tpmSupport = true;
            })
            .fd
          ];
        };
      };
    };
    virtualisation.spiceUSBRedirection.enable = true;
  };
}
