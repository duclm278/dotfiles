" Install vim-plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \| PlugInstall --sync | q
            \| endif

call plug#begin('~/.config/nvim/autoload/plugged')

" Better syntax support
Plug 'sheerun/vim-polyglot'
" File explorer
" Plug 'scrooloose/NERDTree'
" Auto pairs for '(' '[' '{'
Plug 'jiangmiao/auto-pairs'
" Themes
Plug 'arcticicestudio/nord-vim'
Plug 'tomasiser/vim-code-dark'
" Intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Status line
Plug 'vim-airline/vim-airline'
" Cool icons
Plug 'ryanoasis/vim-devicons'
" Ranger
Plug 'kevinhwang91/rnvimr'
" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
" Better comments
Plug 'tpope/vim-commentary'
" Add some color
" Plug 'norcalli/nvim-colorizer.lua'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'junegunn/rainbow_parentheses.vim'
" Start screen
Plug 'mhinz/vim-startify'
" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
" Text navigation
Plug 'easymotion/vim-easymotion'
" Terminal
Plug 'voldikss/vim-floaterm'
" Snippets
Plug 'honza/vim-snippets'
" Undo history visualizer
Plug 'mbbill/undotree'
" Make the yanked region apparent
Plug 'machakann/vim-highlightedyank'

call plug#end()
