{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    system.dns.enable = lib.mkEnableOption "use custom DNS configuration";
  };

  config = lib.mkIf config.system.dns.enable {
    networking.nameservers =
      (
        if config.system.tailscale.enable
        then ["100.100.100.100"]
        else []
      )
      ++ ["1.1.1.1" "1.0.0.1"];
  };
}
