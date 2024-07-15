# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  system.tailscale.enable = false;
  system.dns.enable = false;

  networking.hostName = "devarsh-slg"; # Don't change this!.

  # desktop.kde.enable = true;
  desktop.hyprland.enable = true;

  # Power saving functionality
  powerManagement.enable = true;
  services.thermald = {
    enable = true;
    configFile = ./thermal-conf.xml;
  };
  services.tlp = {
    enable = true;
  };
  services.upower.enable = true;

  # Define a user account. Don't forget to set a password with `passwd`.
  users.users.devarsh = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"]; # Enable `sudo` for the user.
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "devarsh" = import ./home.nix;
    };
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}
