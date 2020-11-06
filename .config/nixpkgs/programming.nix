{ pkgs, lib, ... }:
with pkgs; let
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
  haskell = {
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
  purescript = with easy-ps; {
    home.packages = [
      purs
      spago
      dhall-simple
      zephyr
      nodePackages.purescript-language-server
    ];
  };
  javascript = with pkgs.nodePackages; {
    home.packages = [
      nodejs-14_x
      yarn
      typescript
    ];
  };
  scala =
    let
      java = pkgs.jdk11;
      javaOpts = { jre = java; };
      sbt = pkgs.sbt.override javaOpts;
      scala = pkgs.sbt.override javaOpts;
      coursier = pkgs.coursier.override javaOpts;
      metals = pkgs.metals.override javaOpts;
      scalafmt = pkgs.scalafmt.override javaOpts;
    in
    {
      home.packages = [
        java
        sbt
        scala
        coursier
        scalafmt
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
