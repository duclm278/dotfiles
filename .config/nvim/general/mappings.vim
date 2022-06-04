" Set leader key
let mapleader=" "
nnoremap <Space> <Nop>

" I hate escape more than anything else
inoremap jk <Esc>

" Move up and down in autocomplete
inoremap <expr> <C-j> ("\<C-n>")
inoremap <expr> <C-k> ("\<C-p>")

" Better indenting
vnoremap < <gv
vnoremap > >gv

" Move selected line or block of text
vnoremap J :move '>+1<CR>gv=gv
vnoremap K :move '<-2<CR>gv=gv

" Tab in normal mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" Shift + Tab will go back
nnoremap <S-TAB> :bprevious<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Use Alt + hjkl to resize windows
nnoremap <A-h> <C-w><
nnoremap <A-j> <C-w>-
nnoremap <A-k> <C-w>+
nnoremap <A-l> <C-w>>

" No highlight
nnoremap <leader>n :nohlsearch<CR>

" Better registers
nnoremap <leader>y "+y
nnoremap <leader>d "_d
vnoremap <leader>y "+y
vnoremap <leader>d "_d
xnoremap <leader>p "_dP
