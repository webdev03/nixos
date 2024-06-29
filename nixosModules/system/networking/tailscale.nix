{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    system.tailscale.enable = lib.mkEnableOption "tailscale";
  };
  config = {
    services.tailscale.enable = config.system.tailscale.enable;
    networking.search = ["tail3bfb6.ts.net"]; # My tailnet
    systemd.services."tailscale-fix" = {
      enable = true;
      serviceConfig = {
        ExecStop = "${pkgs.systemd}/bin/systemctl kill --signal=KILL tailscaled";
      };
    };
  };
}
