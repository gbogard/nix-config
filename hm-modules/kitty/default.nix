env:
{
  home.file.".config/kitty/theme.conf".source = ./theme.conf;
  programs.kitty = {
    enable = true;
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
      font_size = 16;
    };
    extraConfig = (builtins.readFile ./kitty.conf);
  };
}
