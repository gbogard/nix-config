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
  (import ./shell.nix { })
  (import ./neovim/neovim.nix {
    inherit config;inherit pkgs;inherit lib;
  })
  (import ./programming.nix { inherit config;inherit pkgs;inherit lib; })
  (import ./ops.nix { inherit config;inherit pkgs;inherit lib; })

]
