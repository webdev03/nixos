{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    system.pipewire.enable = lib.mkEnableOption "PipeWire";
  };
  config = lib.mkIf config.system.pipewire.enable {
    security.rtkit.enable = true;
    sound.enable = lib.mkForce false; # disable alsa
    hardware.pulseaudio.enable = lib.mkForce false; # disable pulseaudio
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = false;
    };
  };
}
