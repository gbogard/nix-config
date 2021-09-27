{ config, lib, ... }:
let
  pkgs = (import ../nixpkgs);
in
{
  # Make mac apps available in /Applications automatically
  # See https://github.com/nix-community/home-manager/issues/1341
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
  programs.zsh.initExtraBeforeCompInit =
    # Initialise nix path on macOs
    ". $HOME/.nix-profile/etc/profile.d/nix.sh;" + ". $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh;";
}
