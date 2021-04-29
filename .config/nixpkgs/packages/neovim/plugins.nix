let
  inherit (import ../../pkgs.nix) unstable;
  inherit (unstable.vimUtils) buildVimPlugin;
in
with unstable;
unstable.vimPlugins // rec {
  plenary-nvim = buildVimPlugin
    {
      name = "plenary-nvim";
      buildPhase = "echo build;";
      src = fetchFromGitHub {
        owner = "nvim-lua";
        repo = "plenary.nvim";
        rev = "a0240b98c0e9ed9b1e0737ca0615d731912c2283";
        sha256 = "11dabihmzymwmrlh58yb0cibh91pbrb0xni4x5cjfi6m14sclrmq";
      };
    };
  telescope-nvim = buildVimPlugin
    {
      name = "telescope-nvim";
      buildPhase = "echo build;";
      src = fetchFromGitHub {
        owner = "nvim-telescope";
        repo = "telescope.nvim";
        rev = "6fd1b3bd255a6ebc2e44cec367ff60ce8e6e6cab";
        sha256 = "1qifrnd0fq9844vvxy9fdp90kkb094a04wcshbfdy4cv489cqfax";
      };
    };
  popup-nvim = buildVimPlugin
    {
      name = "popup-nvim";
      buildPhase = "echo build;";
      src = fetchFromGitHub {
        owner = "nvim-lua";
        repo = "popup.nvim";
        rev = "bc98ca6df9179452c368f0d7bac821a8fd4c01ac";
        sha256 = "0j1gkaba6z5vb922j47i7sq0d1zwkr5581w0nxd8c31klghg3kyn";
      };
    };
  completion-nvim = buildVimPlugin
    {
      name = "completion-nvim";
      buildPhase = "echo build;";
      src = fetchFromGitHub {
        owner = "nvim-lua";
        repo = "completion-nvim";
        rev = "8bca7aca91c947031a8f14b038459e35e1755d90";
        sha256 = "02zqc75p9ggrz6fyiwvzpnzipfd1s5xfr7fli2yypb4kp72mrbaf";
      };
    };
  lspconfig-nvim = buildVimPlugin
    {
      name = "lspconfig-nvim";
      buildPhase = "echo build;";
      src = fetchFromGitHub {
        owner = "neovim";
        repo = "nvim-lspconfig";
        rev = "0840c91e25557a47ed559d2281b0b65fe33b271f";
        sha256 = "1k34khp227g9xffnz0sr9bm6h3hnvi3g9csxynpdzd0s2sbjsfgk";
      };
    };
  lspsaga-nvim = buildVimPlugin
    {
      name = "lspsaga-nvim";
      buildPhase = "echo build;";
      src = fetchFromGitHub {
        owner = "glepnir";
        repo = "lspsaga.nvim";
        rev = "cb0e35d2e594ff7a9c408d2e382945d56336c040";
        sha256 = "0ywhdgh6aqs0xlm8a4d9jhkik254ywagang12r5nyqxawjsmjnib";
      };
    };
  lualine-nvim = buildVimPlugin
    {
      name = "lualine-nvim";
      buildPhase = "echo build;";
      src = fetchFromGitHub {
        owner = "hoob3rt";
        repo = "lualine.nvim";
        rev = "6ba2b80b594c3ead11ab9bd1dbc94c0b4ea46c33";
        sha256 = "0xhdc18sdlbhhyd7p898n4ymyvrhjqbsj5yzb6vmjvc4d9gln1k6";
      };
    };
  lsptrouble-nvim = buildVimPlugin
    {
      name = "lsptrouble-nvim";
      buildPhase = "echo build;";
      src = fetchFromGitHub {
        owner = "folke";
        repo = "lsp-trouble.nvim";
        rev = "f9dd59835e283d2e3a6d1ee616b2eb9a33f8f38a";
        sha256 = "0r646zckw9n6r22j8bicl6qack4kpqc42aqb61vyyi4bci7pvdab";
      };
    };
}
