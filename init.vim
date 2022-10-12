set number
set encoding=utf-8
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2
autocmd FileType html       setlocal shiftwidth=2 tabstop=2

setlocal spell spelllang=en_us
syntax on
set cursorline
set background=light
"set background=dark
set termguicolors

set completeopt=menu,menuone,preview,noselect,noinsert

call plug#begin('~/.config/nvim/plugged')
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'vim-airline/vim-airline'
Plug 'rakr/vim-one'

Plug 'janko/vim-test'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'

Plug 'airblade/vim-gitgutter'
Plug 'simeji/winresizer'
Plug 'tversteeg/registers.nvim', { 'branch': 'main' }

Plug 'scrooloose/nerdtree'
Plug 'cloudhead/neovim-fuzzy'
Plug 'dyng/ctrlsf.vim'

Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
Plug 'dense-analysis/ale'
Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}

Plug 'tpope/vim-commentary'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'maxmellon/vim-jsx-pretty'
Plug 'yuezk/vim-js'
Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
call plug#end()

colorscheme hybrid_material

let g:prettier#autoformat = 0
"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
let g:prettier#config#tab_width = '2'
let g:fuzzy_rootcmds = ['git']

nnoremap <silent> <C-a> :NERDTreeToggle<CR>
nnoremap <silent> <C-f> :FuzzyOpen<CR>
nnoremap <silent> <C-s> :FuzzyGrep<CR>
nmap     <C-\> <Plug>CtrlSFPrompt
nnoremap <C-x> :source $MYVIMRC<CR>

nnoremap <silent> t<C-n> :TestNearest<CR>
nnoremap <silent> t<C-f> :TestFile<CR>
nnoremap <silent> t<C-e> :TestSuite<CR>
nnoremap <silent> t<C-l> :TestLast<CR>
nnoremap <silent> t<C-g> :TestVisit<CR>

let g:airline_theme = "one"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline_powerline_fonts = 1

let test#strategy = "dispatch"

nnoremap <silent> <C-h> :bprevious<CR>
nnoremap <silent> <C-l> :bnext<CR>

let g:mix_format_on_save = 1

let g:ale_completion_enabled = 1
let g:ale_linters = {}
let g:ale_linters.elixir = ['elixir-ls', 'credo']
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace']}
let g:ale_fixers.elixir = ['mix_format']
let g:ale_sign_column_always = 1
let g:ale_elixir_credo_strict = 1
let g:ale_elixir_elixir_ls_release = expand("/Users/arkadiuszplichta/.elixir_ls/release")
let g:ale_elixir_elixir_ls_config = {'elixirLS': {'dialyzerEnabled': v:false}}
let g:ale_sign_error = '!!'
let g:ale_sign_warning = '??'

nnoremap ad :ALEGoToDefinition<cr>
nnoremap ar :ALEFindReferences<cr>
nnoremap as :ALESymbolSearch<cr>
nnoremap K :ALEHover<cr>

highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

let g:gitgutter_sign_added = '++'
let g:gitgutter_sign_modified = '~~'
let g:gitgutter_sign_removed = '--'
let g:gitgutter_sign_removed_first_line = '--'
let g:gitgutter_sign_removed_above_and_below = '--'
let g:gitgutter_sign_modified_removed = '--'
