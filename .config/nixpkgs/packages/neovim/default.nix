{ config, ... }:
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
      v = "nvim";
    };
  };
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    extraConfig = (builtins.readFile ./init.vim);
    plugins = with plugins; [
      barbar-nvim
      quickfix-reflector-vim
      lspconfig-nvim
      nvim-compe
      lspsaga-nvim
      whichkey-nvim
      vim-nix
      plenary-nvim
      popup-nvim
      telescope-nvim
      nvim-web-devicons
      vim-startify
      lualine-nvim
      lsptrouble-nvim
      gitgutter
      {
        plugin = indentLine;
        config = ''
          let g:indentLine_conceallevel = 0
          set conceallevel=2
        '';
      }
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
          let g:nvim_tree_group_empty = 1
          let g:nvim_tree_lsp_diagnostics = 1
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
      {
        plugin = ack-vim;
        config = ''
          let g:ackprg = 'rg --vimgrep --smart-case'
          let g:ack_autoclose = 1
          " Don't jump to first match
          cnoreabbrev Ack Ack!
        '';
      }
    ];
  };
}  
