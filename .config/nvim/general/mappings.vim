" Set leader key
let mapleader=" "
nnoremap <Space> <Nop>

" I hate escape more than anything else
inoremap jk <Esc>

" Move up and down in insert-mode completion
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Move up and down in cmdline-mode completion
cnoremap <expr> <C-j> wildmenumode() ? "\<C-n>" : "\<C-j>"
cnoremap <expr> <C-k> wildmenumode() ? "\<C-p>" : "\<C-k>"

" Better indenting
vnoremap < <gv
vnoremap > >gv

" Move selected line or block of text
nnoremap <silent> <A-j> :m .+1<CR>==
nnoremap <silent> <A-k> :m .-2<CR>==
inoremap <silent> <A-j> <Esc>:m .+1<CR>==gi
inoremap <silent> <A-k> <Esc>:m .-2<CR>==gi
vnoremap <silent> <A-j> :move '>+1<CR>gv=gv
vnoremap <silent> <A-k> :move '<-2<CR>gv=gv

" Navigate buffers
nnoremap <silent> <TAB> :bnext<CR>
nnoremap <silent> <S-TAB> :bprevious<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize with arrows
nnoremap <silent> <C-Left>  :vertical resize -2<CR>
nnoremap <silent> <C-Down>  :resize -2<CR>
nnoremap <silent> <C-Up>    :resize +2<CR>
nnoremap <silent> <C-Right> :vertical resize +2<CR>

" No highlight
nnoremap <silent> <leader>n :nohlsearch<CR>

" Better registers
nnoremap <leader>d "_d
nnoremap <leader>y "+y
vnoremap <leader>d "_d
vnoremap <leader>p "_dP
vnoremap <leader>y "+y
