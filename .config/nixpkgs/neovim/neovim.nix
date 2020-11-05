{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
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
        config = "
          map <C-n> :NERDTreeToggle<CR>
        ";
      }
      coc-metals
      ctrlp-vim
      vim-airline
      vim-gitgutter
      vim-nix
      lexima-vim
      indentLine
      nerdcommenter
      vim-markdown
    ];
  };
}
