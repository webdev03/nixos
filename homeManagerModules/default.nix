{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./desktop/hyprland.nix

    ./cliPrograms/breaktime.nix
    ./cliPrograms/btop.nix
    ./cliPrograms/bun.nix
    ./cliPrograms/cava.nix
    ./cliPrograms/git.nix
    ./cliPrograms/hyperfine.nix
    ./cliPrograms/tree.nix

    ./guiPrograms/blender.nix
    ./guiPrograms/boxes.nix
    ./guiPrograms/firefox.nix
    ./guiPrograms/kicad.nix
    ./guiPrograms/kitty.nix
    ./guiPrograms/krita.nix
    ./guiPrograms/obs-studio.nix
    ./guiPrograms/vlc.nix
    ./guiPrograms/vscodium.nix
  ];

  home.username = lib.mkDefault "devarsh";
  home.homeDirectory = lib.mkDefault "/home/devarsh";
  programs.home-manager.enable = lib.mkDefault true;

  hyprland.enable = lib.mkDefault false;

  cliPrograms.breaktime.enable = lib.mkDefault false;
  cliPrograms.btop.enable = lib.mkDefault true;
  cliPrograms.bun.enable = lib.mkDefault true;
  cliPrograms.cava.enable = lib.mkDefault true;
  cliPrograms.git.enable = lib.mkDefault true;
  cliPrograms.git.gh.enable = lib.mkDefault false;
  cliPrograms.hyperfine.enable = lib.mkDefault true;
  cliPrograms.tree.enable = lib.mkDefault true;

  guiPrograms.blender.enable = lib.mkDefault false;
  guiPrograms.boxes.enable = lib.mkDefault false;
  guiPrograms.firefox.enable = lib.mkDefault true;
  guiPrograms.kicad.enable = lib.mkDefault false;
  guiPrograms.kitty.enable = lib.mkDefault true;
  guiPrograms.krita.enable = lib.mkDefault true;
  guiPrograms.obs-studio.enable = lib.mkDefault true;
  guiPrograms.vlc.enable = lib.mkDefault true;
  guiPrograms.vscodium.enable = lib.mkDefault true;
}
