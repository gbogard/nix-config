{ config, ... }:
let
  pkgs = (import ../../nixpkgs);
in
{
  home.file.".config/nvim/lua/keybindings.lua".source = ./lua/keybindings.lua;
  home.file.".config/nvim/lua/lsp.lua".source = ./lua/lsp.lua;
  home.file.".config/nvim/lua/line.lua".source = ./lua/line.lua;
  home.file.".config/nvim/lua/telescope-config.lua".source = ./lua/telescope-config.lua;
  programs.zsh = rec {
    shellGlobalAliases = {
      neovim = "nvim";
      vi = "nvim";
      vim = "nvim";
      v = "nvim";
    };
    shellAliases = shellGlobalAliases;
  };
  programs.neovim = rec {
    enable = true;
    package = pkgs.neovim-nightly;
    plugins = with pkgs.vimPlugins; [
      barbar-nvim
      cmp-nvim-lsp
      cmp-buffer
      cmp-vsnip
      fugitive
      fzf-vim
      gitgutter
      goyo-vim
      lspkind-nvim
      lspsaga-nvim
      lsptrouble-nvim
      neoformat
      nerdcommenter
      nvim-cmp
      nvim-metals
      nvim-web-devicons
      plenary-nvim
      popup-nvim
      purescript-vim
      quickfix-reflector-vim
      vim-nix
      vim-rescript
      vim-visual-multi
      vim-vsnip
      whichkey-nvim
      telescope-fzf-native-nvim
      { plugin = telescope-nvim; config = "lua require('telescope-config')"; }
      { plugin = vim-startify; config = "let g:startify_change_to_dir = 0"; }
      { plugin = lspconfig-nvim; config = "lua require('lsp')"; }
      { plugin = whichkey-nvim; config = "lua require('keybindings')"; }
      { plugin = lualine-nvim; config = "lua require('line')"; }
      {
        plugin = gruvbox-material;
        config = ''
          set termguicolors
          syntax on
          set background=dark
          colorscheme gruvbox-material
        '';
      }
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
        plugin = ack-vim;
        config = ''
          let g:ackprg = 'rg --vimgrep --smart-case'
          let g:ack_autoclose = 1
          " Don't jump to first match
          cnoreabbrev Ack Ack!
        '';
      }
    ];
    extraConfig = ''
      ${builtins.readFile ./init.vim}
    '';
  };
}
