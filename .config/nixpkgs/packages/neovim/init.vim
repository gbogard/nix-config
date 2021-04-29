" set leader key
let mapleader=' '

set updatetime=500
set timeoutlen=1000 ttimeoutlen=0

lua << EOF
require('keybindings')
require('lsp')
require('line')
EOF

" Clear search highlight with esc
nnoremap <esc> :noh<return><esc>

" folding
set foldmethod=syntax
set foldopen-=block
set nofoldenable

set mouse=a
set number
set nobackup
set nowritebackup
set hidden

" indent
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent

set completeopt=menuone,noselect
