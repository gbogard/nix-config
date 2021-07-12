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
  nvim-compe = buildVimPlugin
    {
      name = "nvim-compe";
      buildPhase = "echo build;";
      src = fetchFromGitHub {
        owner = "hrsh7th";
        repo = "nvim-compe";
        rev = "99452ae6875889c12653963b68e53c4564848954";
        sha256 = "1d5hpn3mr2h3s5h2svajbxm0n49mmc5w0sip9cpzyfdpbnv1gic3";
      };
    };
  lspconfig-nvim = buildVimPlugin
    {
      name = "lspconfig-nvim";
      buildPhase = "echo build;";
      src = fetchFromGitHub {
        owner = "neovim";
        repo = "nvim-lspconfig";
        rev = "cfab466847e0874f03cf5b1bfbd89286827c537c";
        sha256 = "176blqdih86xa8sw65klfs63pqqbyl9mkckcwqgcfy6gfy3y671f";
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
  whichkey-nvim = buildVimPlugin
    {
      name = "whichkey-nvim";
      buildPhase = "echo build;";
      src = fetchFromGitHub {
        owner = "folke";
        repo = "which-key.nvim";
        rev = "d93ef0f2f1a9a6288016a3a82f70399e350a574f";
        sha256 = "15801wxhl227n3gg2a9bh849jr7z8y9m9mlrycnmqxskfrwzy06m";
      };
    };
  vim-rescript = buildVimPlugin
    {
      name = "vim-rescript";
      buildPhase = "echo build;";
      src = fetchFromGitHub {
        owner = "rescript-lang";
        repo = "vim-rescript";
        rev = "b8714edb8fe5ff2b7e32ced3bdeddd31ed08b02e";
        sha256 = "1qzf1g00abj658nvp45nkzjwwdwhbhswpdndrwzsf7y3h2knjlx0";
      };
    };
  barbar-nvim = buildVimPlugin
    {
      name = "barbar-nvim";
      buildPhase = "echo build;";
      src = fetchFromGitHub {
        owner = "romgrk";
        repo = "barbar.nvim";
        rev = "e640b28610e68696095c72a4fb89c5930dde97ab";
        sha256 = "15fh7lgpkk453jkbazaby751p78ppgqw0l5zrdd54g8cvk4y1yil";
      };
    };
  nvim-tree-lua = buildVimPlugin
    {
      name = "nvim-tree-lua";
      pname = "nvim-tree-lua";
      version = "";
      buildPhase = "echo build;";
      src = fetchFromGitHub {
        owner = "kyazdani42";
        repo = "nvim-tree.lua";
        rev = "825cf570bfe833cbf8a44b619364e45ad3616382";
        sha256 = "1wnknr84p2mrqi4pwsd0rgk94szizr2bc69zpnqv9kvh8iq4j7bw";
      };
    };
}
