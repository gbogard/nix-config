" set leader key
let mapleader=' '

lua << EOF
require('keybindings')
require('lsp')
EOF

" Clear search highlight with esc
nnoremap <esc> :noh<return><esc>

" folding
set foldmethod=syntax
set foldopen-=block
set nofoldenable

set number
set nobackup
set nowritebackup
set hidden