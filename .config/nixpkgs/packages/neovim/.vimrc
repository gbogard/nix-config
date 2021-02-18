" set leader key
let mapleader=' '

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

" faster navigation between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Clear search highlight with esc
nnoremap <esc> :noh<return><esc>

" folding
set foldmethod=syntax
set foldopen-=block
set nofoldenable

" better display for messages
set cmdheight=2

set number
set nobackup
set nowritebackup