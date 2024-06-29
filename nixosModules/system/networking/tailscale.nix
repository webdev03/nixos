{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    system.tailscale.enable = lib.mkEnableOption "tailscale";
  };
  config = lib.mkIf config.system.tailscale.enable {
    services.tailscale.enable = true;
    networking.search = ["tail3bfb6.ts.net"]; # My tailnet
    systemd.services."tailscale-fix" = {
      enable = true;
      after = ["tailscaled.target"];
      serviceConfig = {
        ExecStart = "";
        ExecStop = "${pkgs.systemd}/bin/systemctl kill --signal=KILL tailscaled";
      };
    };
  };
}
