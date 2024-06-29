{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./desktop/hyprland.nix
    ./desktop/kde.nix
    ./desktop/sddm-theme.nix

    ./system/bluetooth.nix
    ./system/fonts.nix
    ./system/pipewire.nix

    ./system/boot/kernel.nix
    ./system/boot/plymouth.nix
    ./system/boot/systemd-boot.nix

    ./system/networking/avahi.nix
    ./system/networking/dns.nix
    ./system/networking/tailscale.nix

    ./system/programs/nh.nix

    ./system/services/cups.nix
  ];

  system.bluetooth.enable = lib.mkDefault true;
  system.bluetooth.powerOnBoot = lib.mkDefault false;
  system.fonts.enable = lib.mkDefault true;

  system.pipewire.enable = lib.mkDefault true;

  system.kernel.useLatestKernel = lib.mkDefault true;
  system.plymouth.enable = lib.mkDefault true;
  system.systemd-boot.enable = lib.mkDefault true;

  system.avahi.enable = lib.mkDefault true;
  system.dns.enable = lib.mkDefault true;
  system.tailscale.enable = lib.mkDefault true;

  system.nh.enable = lib.mkDefault true;

  system.printing.enable = lib.mkDefault true;

  desktop.hyprland.enable = lib.mkDefault false;
  desktop.kde.enable = lib.mkDefault false;
  desktop.sddm-theme.enable = lib.mkDefault false;

  networking.networkmanager.enable = lib.mkDefault true;

  time.timeZone = lib.mkDefault "Pacific/Auckland";
  i18n.defaultLocale = lib.mkDefault "en_NZ.UTF-8";

  nix.settings.experimental-features = lib.mkDefault ["nix-command" "flakes"];

  services.power-profiles-daemon.enable = lib.mkForce false;

  programs.dconf.enable = lib.mkDefault true; # some apps need dconf to work properly
}
