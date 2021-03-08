{ lib, config, ... }:
let
  inherit (import ../pkgs.nix) unstable pkgs;
  easy-ps = import
    (pkgs.fetchFromGitHub {
      owner = "justinwoo";
      repo = "easy-purescript-nix";
      rev = "a5fd0328827ac46954db08f624c09eba981f1ab2";
      sha256 = "1g3bk2y8hz0y998yixz3jmvh553kjpj2k7j0xrp4al1jrbdcmgjq";
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
        ghc
        idris2
        stack
        hlint
        ormolu
        cabal-install
      ]
    ];
  };
  purescript = with pkgs; with easy-ps; {
    home.packages = [
      purs
      spago
      dhall-simple
      zephyr
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
  rust =
    let
      rustPkg = pkgs.latest.rustChannels.stable.rust.override {
        extensions = [ "rust-src" ];
      };
    in
    {
      home.packages = [ rustPkg ];
      home.sessionVariables = {
        RUST_SRC_PATH = "${pkgs.latest.rustChannels.stable.rust-src.outPath}";
      };
    };
in
lib.mkMerge [
  haskell
  purescript
  javascript
  scala
  python
  rust
  # Imports
  (import ../packages/neovim/default.nix { inherit config;inherit lib;inherit pkgs; })
]
