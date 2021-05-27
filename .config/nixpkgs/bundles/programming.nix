{ lib, config, ... }:
let
  inherit (import ../pkgs.nix) unstable pkgs;
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
        unstable.haskell-language-server
      ]
    ];
  };
  purescript = with pkgs; with easy-ps; {
    home.packages = [
      purs
      spago
      dhall-simple
      zephyr
      purty
      nodePackages.purescript-language-server
    ];
  };
  javascript = with pkgs; with nodePackages; {
    home.packages = [
      unstable.nodejs
      yarn
      typescript
      serve
    ];
  };
  scala =
    let
      java = unstable.graalvm11-ce;
      javaOpts = { jre = java; };
      # We use an unstable version of sbt to get the sbtn thin client
      sbt = (unstable.sbt.overrideAttrs (old: { installCheckPhase = ""; })).override javaOpts;
      scala = pkgs.scala.override javaOpts;
      coursier = pkgs.coursier.override javaOpts;
      bloop = pkgs.bloop.override javaOpts;
      metals = unstable.metals.override javaOpts;
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
  rustPkg = pkgs.latest.rustChannels.stable.rust.override {
    extensions = [ "rust-src" ];
  };
  rust = {
    home.packages = [ rustPkg ];
    home.sessionVariables = {
      RUST_SRC_PATH = "${pkgs.latest.rustChannels.stable.rust-src.outPath}";
    };
  };
in
lib.mkMerge [
  haskell
  # purescript
  javascript
  scala
  python
  # rust
  # Imports
  (import ../packages/neovim/default.nix { inherit config; })
  (import ../packages/intellij/default.nix)
  (import ../packages/rnix-lsp.nix)
]
