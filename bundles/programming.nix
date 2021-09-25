{ lib, config, ... }:
let
  pkgs = (import ../nixpkgs);
  git = (import ../hm-modules/git.nix);
  easy-ps = import
    (
      pkgs.fetchFromGitHub {
        owner = "justinwoo";
        repo = "easy-purescript-nix";
        rev = "e8a1ffafafcdf2e81adba419693eb35f3ee422f8";
        sha256 = "0bk32wckk82f1j5i5gva63f3b3jl8swc941c33bqc3pfg5cgkyyf";
      }
    )
    {
      inherit pkgs;
    };
  rescript = {
    home.packages = [ pkgs.rescript-lsp ];
  };
  nix = with pkgs; {
    home.packages = [ rnix-lsp ];
  };
  haskell = with pkgs; {
    home.packages = lib.mkMerge [
      (
        with pkgs.haskellPackages; [
          Agda
        ]
      )
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
    {
      home.packages = with pkgs; [
        graalvm11-ce
        sbt
        coursier
        bloop
        scalafmt
        metals
        maven
      ];
      home.sessionVariables.JAVA_HOME = pkgs.graalvm11-ce.home;
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
  neovim = (import ../hm-modules/neovim { inherit config; });
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
