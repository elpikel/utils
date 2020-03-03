:imap jk <Esc>
:set number
set encoding=utf-8
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

call plug#begin('~/.config/nvim/plugged')
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'janko/vim-test'
Plug 'tpope/vim-fugitive'
Plug 'cloudhead/neovim-fuzzy'
Plug 'mhinz/vim-mix-format'
Plug 'elixir-editors/vim-elixir'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
nnoremap <silent> <C-e> :NERDTreeToggle<CR>
nnoremap <silent> <C-f> :FuzzyOpen<CR>
nnoremap <silent> <C-s> :FuzzyGrep<CR>
nnoremap <C-r> :source $MYVIMRC<CR>
call plug#end()

syntax on

set termguicolors
set cursorline
colorscheme hybrid_material

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline_powerline_fonts = 1

let test#strategy = "neovim"
