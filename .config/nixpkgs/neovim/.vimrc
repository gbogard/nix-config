" set leader key
let mapleader=' '

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/target/*,*/node_modules/*

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Clear search highlight with esc
nnoremap <esc> :noh<return><esc>

" folding
set foldmethod=syntax
set foldopen-=block
set nofoldenable

" better display for messages
set cmdheight=2

" always display signs
set signcolumn=yes

set nobackup
set nowritebackup

set number