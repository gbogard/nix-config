let
  inherit (import ../../pkgs.nix) unstable;
  extensions = (import ./extensions.nix);
in
{
  programs.vscode = {
    enable = true;
    package = unstable.vscodium;
    userSettings = {
      "update.channel" = "none";
      "editor.tabSize" = 2;
      "workbench.sideBar.location" = "right";
      "workbench.colorTheme" = "Gruvbox Material Dark";
      "editor.fontFamily" = "Fira Code";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 14;
      "redhat.telemetry.enabled" = false;
    };
    extensions = extensions;
  };
}
