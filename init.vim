" map jk to esc
imap jk <Esc>
" show number
set number
" set encoding
set encoding=utf-8
" indentation
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" English checker
setlocal spell spelllang=en_us

call plug#begin('~/.config/nvim/plugged')
" colorscheme
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'w0ng/vim-hybrid'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'morhetz/gruvbox'
" denite
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
" command bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" :TestFile
Plug 'janko/vim-test'
" :Gblame
Plug 'tpope/vim-fugitive'
" brew instll fzy; brew install rg
Plug 'cloudhead/neovim-fuzzy'
Plug 'rakr/vim-one'
" :MixFormat
Plug 'mhinz/vim-mix-format'
Plug 'elixir-editors/vim-elixir'
" :CocInstall coc-elixir
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
" :NERDTree
Plug 'scrooloose/nerdtree'
" vimux - for communication with tmux
Plug 'benmills/vimux'
Plug 'ctrlpvim/ctrlp.vim'
" window resize
Plug 'simeji/winresizer'
" js
Plug 'maxmellon/vim-jsx-pretty'
Plug 'yuezk/vim-js'
nnoremap <silent> <C-a> :NERDTreeToggle<CR>
nnoremap <silent> <C-f> :FuzzyOpen<CR>
nnoremap <silent> <C-s> :FuzzyGrep<CR>
nnoremap <C-x> :source $MYVIMRC<CR>

nnoremap <silent> t<C-n> :TestNearest<CR>
nnoremap <silent> t<C-f> :TestFile<CR>
nnoremap <silent> t<C-s> :TestSuite<CR>
nnoremap <silent> t<C-l> :TestLast<CR>
nnoremap <silent> t<C-g> :TestVisit<CR>

tmap <C-o> <C-\><C-n>
call plug#end()

syntax on
"set termguicolors
set cursorline
set background=light
"set background=dark
"colorscheme gruvbox
colorscheme hybrid_material
"colorscheme tomorrow-night
"colorscheme bergen

let g:airline_theme = "one"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline_powerline_fonts = 1

let test#strategy = "neovim"

nnoremap <silent> <C-h> :bprevious<CR>
nnoremap <silent> <C-l> :bnext<CR>

let g:mix_format_on_save = 1

"ALE conf"
set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_completion_enabled = 1

let g:ale_linters = {}
let g:ale_linters.elixir = ['elixir-ls', 'credo']

let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace']}
let g:ale_fixers.elixir = ['mix_format']

let g:ale_sign_column_always = 1
let g:ale_elixir_credo_strict = 1

let g:ale_elixir_elixir_ls_release = expand("/Users/arkadiuszplichta/.elixir-ls/rel")
let g:ale_elixir_elixir_ls_config = {'elixirLS': {'dialyzerEnabled': v:false}}

nnoremap ad :ALEGoToDefinition<cr>
nnoremap ar :ALEFindReferences<cr>
nnoremap as :ALESymbolSearch<cr>
nnoremap K :ALEHover<cr>

" === Denite shorcuts === "
"   ;         - Browser currently open buffers
"   <leader>t - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
nmap ; :Denite buffer<CR>
nmap <leader>t :DeniteProjectDir file/rec<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:.<CR>

" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
"   <C-t>         - Open currently selected file in a new tab
"   <C-v>         - Open currently selected file a vertical split
"   <C-h>         - Open currently selected file in a horizontal split
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o>
  \ <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  inoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  inoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
"   <C-t>       - Open currently selected file in a new tab
"   <C-v>       - Open currently selected file a vertical split
"   <C-h>       - Open currently selected file in a horizontal split
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o>
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction
