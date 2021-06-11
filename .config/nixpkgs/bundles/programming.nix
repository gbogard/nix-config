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
  git = {
    programs.git = {
      enable = true;
      userName = "Guillaume Bogard";
      userEmail = "hey@guillaumebogard.dev";
      extraConfig = {
        core.editor = "nvim";
        core.exludesFile = "~/.config/git/ignore";
        pull.rebase = "false";
        http.sslVerify = "false";
      };
    };
  };
  neovim = (import ../packages/neovim/default.nix { inherit config; });
  rnixLsp = (import ../packages/rnix-lsp.nix);
in
{
  inherit haskell;
  inherit purescript;
  inherit javascript;
  inherit scala;
  inherit python;
  inherit rust;
  inherit git;
  inherit neovim;
  inherit rnixLsp;
  all = lib.mkMerge [
    haskell
    purescript
    javascript
    scala
    python
    rust
    git
    neovim
    rnixLsp
  ];
}
