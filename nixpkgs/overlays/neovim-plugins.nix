self: super:
let
  pkgs = (import ../../nixpkgs);
  fromGithub = { owner, repo, rev, sha256 }:
    pkgs.vimUtils.buildVimPlugin {
      name = repo;
      pname = repo;
      version = rev;
      buildPhase = "echo build;";
      src = pkgs.fetchFromGitHub { inherit owner repo rev sha256; };
    };
  additionalPlugins = {
    plenary-nvim = fromGithub {
      owner = "nvim-lua";
      repo = "plenary.nvim";
      rev = "8bae2c1fadc9ed5bfcfb5ecbd0c0c4d7d40cb974";
      sha256 = "1axvjv6n77afkjqk914dpc020kxd7mig6m5sr916k1n1q35jc4ny";
    };
    telescope-nvim = fromGithub {
      owner = "nvim-telescope";
      repo = "telescope.nvim";
      rev = "5692edd004fed1dbd55c90775c34a051298724e7";
      sha256 = "0mzgbnm9ic173spnm9w9da7yl79fqg6p7s1sv0w3d3m7qqvz0bpz";
    };
    popup-nvim = fromGithub {
      owner = "nvim-lua";
      repo = "popup.nvim";
      rev = "5e3bece7b4b4905f4ec89bee74c09cfd8172a16a";
      sha256 = "1k6rz652fjkzhjd8ljr0l6vfispanrlpq0r4aya4qswzxni4rxhg";
    };
    vim-vsnip = fromGithub {
      owner = "hrsh7th";
      repo = "vim-vsnip";
      rev = "e0b3a6bb28d2418978715942aded4d9a9f2404f5";
      sha256 = "1f0a4jm8wqwyk50p6yxm0bh7wkd3scgr9dwfhz0mz5hmd3bzcl8k";
    };
    nvim-cmp = fromGithub {
      owner = "hrsh7th";
      repo = "nvim-cmp";
      rev = "b185e303bd00390325c582d0366f85298cf84299";
      sha256 = "12ssag1nlg01vy1x8ip8mfclcklmvkysf3mvg6223scawy2kggk7";
    };
    cmp-nvim-lsp = fromGithub {
      owner = "hrsh7th";
      repo = "cmp-nvim-lsp";
      rev = "accbe6d97548d8d3471c04d512d36fa61d0e4be8";
      sha256 = "1dqx6yrd60x9ncjnpja87wv5zgnij7qmzbyh5xfyslk67c0i6mwm";
    };
    cmp-vsnip = fromGithub {
      owner = "hrsh7th";
      repo = "cmp-vsnip";
      rev = "1588c35bf8f637e8f5287477f31895781858f970";
      sha256 = "0q3z0f7d53cbqidx8qd3z48b46a83l5ay54iw525w22j1kki3aaw";
    };
    cmp-buffer = fromGithub {
      owner = "hrsh7th";
      repo = "cmp-buffer";
      rev = "5dde5430757696be4169ad409210cf5088554ed6";
      sha256 = "0fdywbv4b0z1kjnkx9vxzvc4cvjyp9mnyv4xi14zndwjgf1gmcwl";
    };
    lspconfig-nvim = fromGithub {
      owner = "neovim";
      repo = "nvim-lspconfig";
      rev = "cfab466847e0874f03cf5b1bfbd89286827c537c";
      sha256 = "176blqdih86xa8sw65klfs63pqqbyl9mkckcwqgcfy6gfy3y671f";
    };
    lspsaga-nvim = fromGithub {
      owner = "glepnir";
      repo = "lspsaga.nvim";
      rev = "cb0e35d2e594ff7a9c408d2e382945d56336c040";
      sha256 = "0ywhdgh6aqs0xlm8a4d9jhkik254ywagang12r5nyqxawjsmjnib";
    };
    lualine-nvim = fromGithub {
      owner = "hoob3rt";
      repo = "lualine.nvim";
      rev = "6ba2b80b594c3ead11ab9bd1dbc94c0b4ea46c33";
      sha256 = "0xhdc18sdlbhhyd7p898n4ymyvrhjqbsj5yzb6vmjvc4d9gln1k6";
    };
    lsptrouble-nvim = fromGithub {
      owner = "folke";
      repo = "lsp-trouble.nvim";
      rev = "f9dd59835e283d2e3a6d1ee616b2eb9a33f8f38a";
      sha256 = "0r646zckw9n6r22j8bicl6qack4kpqc42aqb61vyyi4bci7pvdab";
    };
    whichkey-nvim = fromGithub {
      owner = "folke";
      repo = "which-key.nvim";
      rev = "d93ef0f2f1a9a6288016a3a82f70399e350a574f";
      sha256 = "15801wxhl227n3gg2a9bh849jr7z8y9m9mlrycnmqxskfrwzy06m";
    };
    vim-rescript = fromGithub {
      owner = "rescript-lang";
      repo = "vim-rescript";
      rev = "b8714edb8fe5ff2b7e32ced3bdeddd31ed08b02e";
      sha256 = "1qzf1g00abj658nvp45nkzjwwdwhbhswpdndrwzsf7y3h2knjlx0";
    };
    barbar-nvim = fromGithub {
      owner = "romgrk";
      repo = "barbar.nvim";
      rev = "e640b28610e68696095c72a4fb89c5930dde97ab";
      sha256 = "15fh7lgpkk453jkbazaby751p78ppgqw0l5zrdd54g8cvk4y1yil";
    };
    nvim-tree-lua = fromGithub {
      owner = "kyazdani42";
      repo = "nvim-tree.lua";
      rev = "f178c8c8c5cb994326578a24d3296dde6f2e9bd3";
      sha256 = "1xdakhjsjfx7y3dqi99ldgwmh69jyyvisqainlkiz63g0nsy81ay";
    };
    gruvbox-material = fromGithub {
      owner = "sainnhe";
      repo = "gruvbox-material";
      rev = "7a1d276a3d938d488d2d592fbb52ecec642268fc";
      sha256 = "1pvdlci25qr122gzrb661bpl62sfz81vxsbyzwwnf16b18qsxi5r";
    };
    nvim-metals = fromGithub {
      owner = "scalameta";
      repo = "nvim-metals";
      rev = "cac8c02d28f8923bfda75706040e4177e1bd3fab";
      sha256 = "1p0p8qx8lw1yvbk6mgclzpzqfwhc0k2ax2yjkamwj9c653lzwx3c";
    };
    lspkind-nvim = fromGithub {
      owner = "onsails";
      repo = "lspkind-nvim";
      rev = "0f7851772ebdd5cb67a04b3d3cda5281a1eb83c1";
      sha256 = "0jk1xlp8x6vw40dl96zvmdxv0p8100rzx7za58xpahz10232lckx";
    };
    vim-startify = fromGithub {
      owner = "mhinz";
      repo = "vim-startify";
      rev = "3ffa62fbe781b3df20fafa3bd9d710dc99c16a8c";
      sha256 = "0ysr07yy9fxgz8drn11hgcwns7d0minh4afrjxrz9lwcm7c994h4";
    };
  };
  fixPluginPath = name: pkg: pkg.overrideAttrs (old: {
    postInstall = ''
      	cp -r $out/share/vim-plugins/${old.pname}/* $out;
    '';
  });
in { vimPlugins = pkgs.lib.mapAttrs fixPluginPath (super.vimPlugins // additionalPlugins); }
