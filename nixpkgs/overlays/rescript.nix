self: super: {
  rescript-lsp = super.stdenv.mkDerivation rec {
    pname = "rescriptls";
    version = "0.0.0";
    src = super.fetchurl {
      url = "https://github.com/rescript-lang/rescript-vscode/releases/download/1.1.2/rescript-vscode-1.1.2.vsix";
      sha256 = "0a2nbm0rr17d4afj8kzqfgbbmiazyap4n57lj774mpbz0hinw3a4";
    };
    buildInputs = [
      super.unzip
    ];
    unpackPhase = "unzip $src";
    configurePhase = ":";
    buildPhase = ''
      mkdir -p $out/rescriptls
      cp -r extension $out/rescriptls'';
    installPhase = ":";
  };
}
