" set leader key
let mapleader=' '

set noautochdir
set updatetime=300
set timeoutlen=1000 ttimeoutlen=0

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

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" custom commands
command! HoogleOpen call system('open https://hoogle.haskell.org/')

" Treat sbt files like scala files
au BufRead,BufNewFile *.sbt set filetype=scala
