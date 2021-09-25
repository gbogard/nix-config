{ config, lib, ... }:
let
  pkgs = (import ./nixpkgs);
  machine = (import ./machine.nix);
  baseConfig =
    {
      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;
      home.file.".config/git/ignore".source = ./gitignore;
      home.packages = with pkgs; [
        nix-prefetch-scripts
        nixpkgs-fmt
        htop
        ripgrep
      ];
      home.stateVersion = "21.03";
    };
  # Make mac apps available in /Applications automatically
  # See https://github.com/nix-community/home-manager/issues/1341
  darwinConfig = {
    home.activation = {
      copyApplications =
        let
          apps = pkgs.buildEnv {
            name = "home-manager-applications";
            paths = config.home.packages;
            pathsToLink = "/Applications";
          };
        in
        lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          baseDir="$HOME/Applications/Home Manager Apps"
          if [ -d "$baseDir" ]; then
            rm -rf "$baseDir"
          fi
          mkdir -p "$baseDir"
          for appFile in ${apps}/Applications/*; do
            target="$baseDir/$(basename "$appFile")"
            $DRY_RUN_CMD cp ''${VERBOSE_ARG:+-v} -fHRL "$appFile" "$baseDir"
            $DRY_RUN_CMD chmod ''${VERBOSE_ARG:+-v} -R +w "$target"
          done
        '';
    };
  };
  programming = (import ./bundles/programming.nix { inherit config; inherit lib; });
  apps = (import ./bundles/apps.nix { inherit lib; });
  shell = (import ./bundles/shell.nix { inherit lib; });
  ops = (import ./bundles/ops.nix { inherit lib; });
  perHostConfig = {
    "MBPdeGuillaume" = lib.mkMerge [
      {
        home.username = "guillaumebogard";
        home.homeDirectory = "/Users/guillaumebogard";
      }
      shell
      programming.all
      ops
      apps
    ];
    # Canal+ 16" MBP
    "FRPARMAC2102331" = lib.mkMerge [
      {
        home.username = "gbogard";
        home.homeDirectory = "/Users/gbogard";
      }
      shell
      programming.scala
      programming.neovim
      programming.haskell
      programming.git
      programming.web
      programming.nix
      programming.rescript
      ops
      apps
    ];
  };
in
lib.mkMerge [
  baseConfig
  (lib.mkIf (machine.operatingSystem == "Darwin") darwinConfig)
  (perHostConfig."${machine.hostname}")
]
