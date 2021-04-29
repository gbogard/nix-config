let
  inherit (import ../../pkgs.nix) unstable;
in
{
  programs.vscode = {
    enable = true;
    package = unstable.vscodium;
    userSettings = {
      "update.channel" = "none";
      "editor.tabSize" = 2;
      "workbench.sideBar.location" = "right";
    };
    extensions = with unstable.vscode-extensions; [
      dbaeumer.vscode-eslint
      scalameta.metals
      haskell.haskell
      vscodevim.vim
    ];
  };
}
