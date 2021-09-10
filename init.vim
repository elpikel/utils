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
" command bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" :TestFile
Plug 'janko/vim-test'
Plug 'tpope/vim-dispatch'
" :Gblame
Plug 'tpope/vim-fugitive'
" brew instll fzy; brew install rg
Plug 'cloudhead/neovim-fuzzy'
Plug 'rakr/vim-one'
" :MixFormat
Plug 'mhinz/vim-mix-format'
Plug 'elixir-editors/vim-elixir'
" analysis
Plug 'dense-analysis/ale'
" :NERDTree
Plug 'scrooloose/nerdtree'
" window resize
Plug 'simeji/winresizer'
" js
Plug 'maxmellon/vim-jsx-pretty'
Plug 'yuezk/vim-js'
" search
Plug 'eugen0329/vim-esearch'
" prettier
Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
let g:prettier#config#tab_width = '2'

nnoremap <silent> <C-a> :NERDTreeToggle<CR>
nnoremap <silent> <C-f> :FuzzyOpen<CR>
nnoremap <silent> <C-s> :FuzzyGrep<CR>
nnoremap <C-x> :source $MYVIMRC<CR>

nnoremap <silent> t<C-n> :TestNearest<CR>
nnoremap <silent> t<C-f> :TestFile<CR>
nnoremap <silent> t<C-e> :TestSuite<CR>
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

let test#strategy = "dispatch"

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
