env:
let
  pkgs = import ../../nixpkgs;
  extensions = (import ./extensions.nix);
in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    userSettings = {
      "update.channel" = "none";
      "editor.tabSize" = 2;
      "workbench.sideBar.location" = "right";
      "workbench.colorTheme" = "Gruvbox Material Dark";
      "editor.fontFamily" = "Fira Code, FiraCode NF, FiraCode Nerd Font";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 14;
      "redhat.telemetry.enabled" = false;
      "workbench.iconTheme" = "material-icon-theme";
      "editor.mouseWheelZoom" = true;
    };
    extensions = extensions;
  };
}
