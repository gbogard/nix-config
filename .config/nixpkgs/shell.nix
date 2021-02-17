{ lib, ... }:
let
  inherit (import ./pkgs.nix) pkgs;
  machine = (import ./machine.nix);
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
      ];
      initExtra =
        # Start starship
        "source <(starship init zsh --print-full-init);" +
        # Configure bindings for history search
        "bindkey '^[[A' history-substring-search-up;
         bindkey '^[[B' history-substring-search-down;" +
        # Set auto cd
        "setopt auto_cd;";
      shellAliases = {
        ps = "procs";
        ls = "exa";
      };
    };
    programs.tmux = {
      enable = true;
      newSession = true;
      keyMode = "vi";
      extraConfig = ''
        unbind C-b
        set -g prefix C-Space
        bind Space send-prefix
        set -g mouse on
        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
      '';
    };
    home.packages = [
      starship
      exa
      procs
      tokei
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
