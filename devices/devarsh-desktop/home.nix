{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [inputs.self.outputs.homeManagerModules.default];
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  hyprland.enable = true;
  cliPrograms.breaktime.enable = true;

  cliPrograms.git.gh.enable = true;

  guiPrograms.boxes.enable = true;
  guiPrograms.kicad.enable = true;
}
