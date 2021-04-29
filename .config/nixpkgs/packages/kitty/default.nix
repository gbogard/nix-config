let
  inherit (../../pkgs.nix) pkgs;
in
{
  home.file.".config/kitty/theme.conf".source = ./theme.conf;
  programs.kitty = {
    enable = true;
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
      font_size = 16;
      enabled_layouts = "tall:bias=65;full_size=1;mirrored=false, fat:bias=60;full_size=1;mirrored=1";
    };
    font.name = "FiraCode Nerd Font";
    extraConfig = (builtins.readFile ./kitty.conf);
  };
}
