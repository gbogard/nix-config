{ lib, ... }:
let
  inherit (import ../../pkgs.nix) pkgs;
  machine = (import ../../machine.nix);
in
with pkgs; lib.mkMerge [
  {
    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      plugins = [
        {
          name = "zsh-vim-mode";
          src = pkgs.fetchFromGitHub {
            owner = "softmoth";
            repo = "zsh-vim-mode";
            rev = "abef0c0c03506009b56bb94260f846163c4f287a";
            sha256 = "0cnjazclz1kyi13m078ca2v6l8pg4y8jjrry6mkvszd383dx1wib";
          };
        }
        {
          name = "zsh-aliases-exa";
          src = pkgs.fetchFromGitHub {
            owner = "DarrinTisdale";
            repo = "zsh-aliases-exa";
            rev = "f6b72da193f03911009cb95e3e2e18e48b918833";
            sha256 = "0xzdahcahjv2mag5g7kzidg3bg0g01xwn0j47fwpsa0knpcsx1c7";
          };
        }
        {
          name = "zsh-history-substring-search";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-history-substring-search";
            rev = "0f80b8eb3368b46e5e573c1d91ae69eb095db3fb";
            sha256 = "0y8va5kc2ram38hbk2cibkk64ffrabfv1sh4xm7pjspsba9n5p1y";
          };
        }
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.1.0";
            sha256 = "0snhch9hfy83d4amkyxx33izvkhbwmindy0zjjk28hih1a9l2jmx";
          };
        }
      ];
      initExtra = (builtins.readFile ./config.sh);
      shellAliases = {
        ps = "procs";
        ls = "exa";
      };
    };
    home.packages = [
      starship
      direnv
    ];
  }
  (lib.mkIf (machine.operatingSystem == "Darwin") {
    programs.zsh.initExtraBeforeCompInit =
      # Initialise nix path on macOs
      ". $HOME/.nix-profile/etc/profile.d/nix.sh;" +
      ". $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh;";
  })
  (lib.mkIf (machine.operatingSystem == "Ubuntu") {
    programs.zsh.initExtraBeforeCompInit =
      # Initialise nix path on Ubuntu (multi-user setup)
      "export PATH=\"$PATH:/nix/var/nix/profiles/default/bin\"
       export PATH=\"$PATH:/nix/var/nix/profiles/per-user/$USER/profile/bin\"
       export NIX_PATH=$HOME/.nix-defexpr/channels\${NIX_PATH:+:}$NIX_PATH";
  })
]
