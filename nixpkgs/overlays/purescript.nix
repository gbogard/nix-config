self: super:
let
  easy-ps = import
    (
      super.fetchFromGitHub {
        owner = "justinwoo";
        repo = "easy-purescript-nix";
        rev = "e8a1ffafafcdf2e81adba419693eb35f3ee422f8";
        sha256 = "0bk32wckk82f1j5i5gva63f3b3jl8swc941c33bqc3pfg5cgkyyf";
      }
    )
    { pkgs = super; };
in
  with easy-ps; {
    inherit spago;
    inherit purs;
    inherit purescript-language-server;
    inherit zephyr;
    inherit purty;
    inherit dhall-simple;
  }
