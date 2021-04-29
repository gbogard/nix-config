{ config, }:
let
  inherit (import ../../pkgs.nix) pkgs unstable;
  plugins = (import ./plugins.nix);
in
{
  home.packages = [
    ((import ./neovim-with-cd.nix) { inherit config; })
  ];
  home.file.".config/nvim/lua/whichkey_setup.lua".source = ./lua/whichkey_setup.lua;
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
      haskell-vim
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
        plugin = nvim-tree-lua;
        config = ''
          let g:nvim_tree_side = 'right'
          let g:nvim_tree_auto_close = 1
        '';
      }
      {
        plugin = vim-which-key;
        config = ''
          set timeoutlen=500
          nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
        '';
      }
      {
        plugin = oceanic-next;
        config = ''
          set termguicolors
          syntax on
          let g:airline_theme='oceanicnext'
          colorscheme OceanicNext
        '';
      }
    ];
  };
}  
