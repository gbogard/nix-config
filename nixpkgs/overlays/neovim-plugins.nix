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
    completion-nvim = fromGithub {
      owner = "nvim-lua";
      repo = "completion-nvim";
      rev = "139fb6cfbd9f7384a5489d3e4afdacb8ed977ab0";
      sha256 = "1641gx74mqbsp42m6z695l8xlr56b79vklghjdxywi35xbz4yq22";
    };
    completion-buffers = fromGithub {
      owner = "steelsojka";
      repo = "completion-buffers";
      rev = "c36871b2a44b59761387f4972c617b44dcec5e75";
      sha256 = "14rxmy3cjrl7lr4yvrk7nkhc5h8rlpj7xjixzgr0vmnbsl885kyh";
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
  };
  fixPluginPath = name: pkg: pkg.overrideAttrs (old: {
    postInstall = ''
      	cp -r $out/share/vim-plugins/${old.pname}/* $out;
    '';
  });
in { vimPlugins = pkgs.lib.mapAttrs fixPluginPath (super.vimPlugins // additionalPlugins); }
