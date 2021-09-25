let
  pkgs = (import ../nixpkgs);
in
{
  home.packages = [ pkgs.delta ];
  programs.git = {
    enable = true;
    userName = "Guillaume Bogard";
    userEmail = "hey@guillaumebogard.dev";
    extraConfig = {
      core.editor = "nvim";
      core.exludesFile = "~/.config/git/ignore";
      pull.rebase = "false";
      http.sslVerify = "false";
      pager = {
        diff = "delta";
        log = "delta";
        reflog = "delta";
        show = "delta";
      };
      delta = {
        features = "line-numbers decorations";
        navigate = true;
      };
      interactive.diffFilter = "delta --color-only";
    };
  };
}
