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

" Move selected line or block of text in visual mode
vnoremap K :move '<-2<CR>gv=gv
vnoremap J :move '>+1<CR>gv=gv

" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Use alt + hjkl to resize windows
nnoremap <M-j> :resize -2<CR>
nnoremap <M-k> :resize +2<CR>
nnoremap <M-h> :vertical resize -2<CR>
nnoremap <M-l> :vertical resize +2<CR>

" No highlight
nnoremap <leader>n :nohlsearch<CR>

" Better registers
nnoremap <leader>y "+y
vnoremap <leader>y "+y
vnoremap <leader>p "_dP
nnoremap <leader>d "_d
vnoremap <leader>d "_d
