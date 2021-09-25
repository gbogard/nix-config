{ lib, config, ... }:
let
  pkgs = (import ../nixpkgs);
  rescriptLsp = (import ../packages/rescript-lsp.nix);
  easy-ps = import
    (pkgs.fetchFromGitHub {
      owner = "justinwoo";
      repo = "easy-purescript-nix";
      rev = "e8a1ffafafcdf2e81adba419693eb35f3ee422f8";
      sha256 = "0bk32wckk82f1j5i5gva63f3b3jl8swc941c33bqc3pfg5cgkyyf";
    })
    {
      inherit pkgs;
    };
  rescript = {
    home.packages = [ rescriptLsp ];
  };
  nix = with pkgs; {
    home.packages = [ rnix-lsp ];
  };
  haskell = with pkgs; {
    home.packages = lib.mkMerge [
      (with pkgs.haskellPackages; [
        Agda
      ])
      [
        idris2
        stack
        hlint
        ormolu
        cabal-install
        haskell-language-server
      ]
    ];
  };
  purescript = with pkgs; with easy-ps; {
    home.packages = [
      purs
      spago
      dhall-simple
      zephyr
      nodePackages.pkgs
    ];
  };
  web = with pkgs; with nodePackages; {
    home.packages = [
      nodejs
      yarn
      geckodriver
      serve
      vscode-langservers-extracted
      typescript
      typescript-language-server
    ];
  };
  scala =
    let
      java = pkgs.graalvm11-ce;
      javaOpts = { jre = java; };
      sbt = (pkgs.sbt.overrideAttrs (old: { installCheckPhase = ""; })).override javaOpts;
      scala = pkgs.scala.override javaOpts;
      coursier = pkgs.coursier.override javaOpts;
      bloop = pkgs.bloop.override javaOpts;
      metals = pkgs.metals.override javaOpts;
      scalafmt = pkgs.scalafmt.override javaOpts;
      maven = pkgs.maven.override { jdk = java; };
    in
    {
      home.packages = [
        java
        sbt
        scala
        coursier
        bloop
        scalafmt
        metals
        maven
      ];
      home.sessionVariables.JAVA_HOME = java.home;
    };
  python = with pkgs; {
    home.packages = [
      python38Full
      python38Packages.pip
    ];
  };
  rust = with pkgs; {
    home.packages = [ rust-bin.stable.latest.default ];
  };
  git = {
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
  };
  neovim = (import ../packages/neovim/default.nix { inherit config; });
in
{
  inherit haskell;
  inherit purescript;
  inherit web;
  inherit scala;
  inherit rust;
  inherit python;
  inherit rescript;
  inherit git;
  inherit neovim;
  inherit nix;
  all = lib.mkMerge [
    haskell
    purescript
    web
    scala
    rust
    python
    rescript
    git
    neovim
    nix
  ];
}
