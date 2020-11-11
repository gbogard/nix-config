{ lib, ... }:
 let
  inherit (import ./pkgs.nix) unstable pkgs;
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
        haskell-language-server
      ])
      [
        ghc
        idris2
        stack
        hlint
        ormolu
        ghcid
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
      nodejs-14_x
      yarn
      typescript
      serve
    ];
  };
  scala =
    let
      java = pkgs.jdk11;
      javaOpts = { jre = java; };
      # We use an unstable version of sbt to get the sbtn thin client
      sbt = unstable.sbt.override javaOpts;
      scala = pkgs.scala.override javaOpts;
      coursier = pkgs.coursier.override javaOpts;
      bloop = pkgs.bloop.override javaOpts;
      metals = pkgs.metals.override javaOpts;
      scalafmt = pkgs.scalafmt.override javaOpts;
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
      ];
      home.sessionVariables.JAVA_HOME = java.home;
    };
in
lib.mkMerge [
  haskell
  purescript
  javascript
  scala
]
