{ config, lib, ... }:
let inherit (import ./pkgs.nix) pkgs;
  machine = (import ./machine.nix);
in
lib.mkMerge [
  {
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    programs.git = {
      enable = true;
      userName = "Guillaume Bogard";
      userEmail = "hey@guillaumebogard.dev";
      extraConfig.core.editor = "nvim";
    };

    home.packages = with pkgs; [
      htop
      nix-prefetch-scripts
      nixpkgs-fmt
      drill
      curl
      wget
      ripgrep
      youtube-dl
    ];

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "21.03";
  }
  # Make mac apps available in /Applications automatically
  # See https://github.com/nix-community/home-manager/issues/1341
  (lib.mkIf (machine.operatingSystem == "Darwin")
    {
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
    })
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  (lib.mkIf (machine.hostname == "nananas-xubuntu") {
    home.username = "guillaune";
    home.homeDirectory = "/home/guillaume";
  })
  (lib.mkIf (machine.hostname == "MBPdeGuillaume") {
    home.username = "guillaumebogard";
    home.homeDirectory = "/Users/guillaumebogard";
  })
  # Imports
  (import ./bundles/apps.nix { inherit lib; })
  (import ./bundles/shell.nix { inherit lib; })
  (import ./bundles/programming.nix { inherit config;inherit lib; })
  (import ./bundles/ops.nix { inherit lib; })
]
