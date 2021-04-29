{ lib, ... }:
let
  inherit (import ../pkgs.nix) pkgs;
in
lib.mkMerge [
  {
    home.packages = with pkgs; [
    ];
    programs.kitty = {
      enable = true;
      settings = {
        scrollback_lines = 10000;
        enable_audio_bell = false;
        update_check_interval = 0;
        font_size = 14;
      };
      font.name = "FiraCode Nerd Font";
    };
  }
  (import ../packages/vscode/default.nix)
]
