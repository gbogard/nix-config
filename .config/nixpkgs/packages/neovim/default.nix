{ config, }:
let
  inherit (import ../../pkgs.nix) pkgs unstable;
  plugins = (import ./plugins.nix);
in
{
  home.packages = [
    ((import ./neovim-with-cd.nix) { inherit config; })
  ];
  home.file.".config/nvim/lua/keybindings.lua".source = ./lua/keybindings.lua;
  home.file.".config/nvim/lua/lsp.lua".source = ./lua/lsp.lua;
  home.file.".config/nvim/lua/line.lua".source = ./lua/line.lua;
  programs.zsh = {
    shellGlobalAliases = {
      neovim = "nvim";
      vi = "nvim";
      vim = "nvim";
    };
  };
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    extraConfig = (builtins.readFile ./init.vim);
    plugins = with plugins; [
      lspconfig-nvim
      completion-nvim
      lspsaga-nvim
      whichkey-nvim
      vim-nix
      plenary-nvim
      popup-nvim
      telescope-nvim
      nvim-web-devicons
      indentLine
      vim-startify
      lualine-nvim
      lsptrouble-nvim
      {
        plugin = haskell-vim;
        config = ''
          let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
          let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
          let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
          let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
          let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
          let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
          let g:haskell_backpack = 1  
          '';
      }
      {
        plugin = nvim-tree-lua;
        config = ''
          let g:nvim_tree_side = 'right'
          let g:nvim_tree_auto_close = 1
        '';
      }
      {
        plugin = palenight-vim;
        config = ''
          set termguicolors
          syntax on
          set background=dark
          colorscheme palenight
        '';
      }
    ];
  };
}  
