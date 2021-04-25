{ config }:
let
  inherit (import ../../pkgs.nix) pkgs;
in
rec {
  home.packages = [
    ((import ./neovim-with-cd.nix) { inherit config; })
  ];
  programs.zsh = {
    shellGlobalAliases = {
      vi = "nvim";
      vim = "nvim";
    };
  };
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    extraConfig = (builtins.readFile ./.vimrc);
    plugins = with pkgs.vimPlugins; [
      # Monokai theme
      {
        plugin = vim-monokai;
        config = "
          syntax on
          colorscheme monokai
        ";
      }
      {
        plugin = coc-nvim;
        config = "
        set hidden
        set updatetime=300 

        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)

        command! -nargs=0 Format :call CocAction('format')
        autocmd CursorHold * silent call CocActionAsync('highlight')
        ";
      }
      {
        plugin = nerdtree;
        config = ''
          let g:NERDTreeWinPos = "right"
          map <C-n> :NERDTreeToggle<CR>
          let NERDTreeShowHidden=1
          let NERDTreeQuitOnOpen=1
        '';
      }
      {
        plugin = ctrlp-vim;
        config = "
        set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/target/*,*/node_modules/*
        let g:ctrlp_show_hidden = 1
        ";
      }
      {
        plugin = vim-gitgutter;
        config = "
        set signcolumn=yes
        ";
      }
      {
        plugin = ack-vim;
        config = ''
          " Use ripgrep for searching ⚡️
          " Options include:
          " --vimgrep -> Needed to parse the rg response properly for ack.vim
          " --type-not sql -> Avoid huge sql file dumps as it slows down the search
          " --smart-case -> Search case insensitive if all lowercase pattern, Search case sensitively otherwise
          let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'

          " Auto close the Quickfix list after pressing '<enter>' on a list item
          let g:ack_autoclose = 1

          " Any empty ack search will search for the work the cursor is on
          let g:ack_use_cword_for_empty_search = 1

          " Don't jump to first match
          cnoreabbrev Ack Ack!

          " Maps <leader>/ so we're ready to type the search keyword
          nnoremap <Leader>/ :Ack!<Space>
          " }}}

          " Navigate quickfix list with ease
          nnoremap <silent> [q :cprevious<CR>
          nnoremap <silent> ]q :cnext<CR>
        '';
      }
      {
        plugin = vimux;
        config = "";
      }
      coc-metals
      vim-airline
      vim-nix
      lexima-vim
      indentLine
      nerdcommenter
      vim-markdown
    ];
  };
}
