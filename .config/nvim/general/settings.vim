syntax enable

set number
set relativenumber
set laststatus=2
set hidden
set incsearch
set hlsearch
set ignorecase
set smartcase
set mouse=a

set autoindent
set smartindent
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

set nowrap
set splitbelow
set splitright
set cursorline
set timeoutlen=500
" set clipboard=unnamedplus

set scrolloff=5
set noswapfile
" set textwidth=80
" set colorcolumn=+1

" Stop new line continuation of comments
au BufEnter * set fo-=c fo-=r fo-=o

" You can't stop me
cmap w!! w !sudo tee %
