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
" command bar
Plug 'vim-airline/vim-airline'
" :TestFile
Plug 'janko/vim-test'
Plug 'tpope/vim-dispatch'
Plug 'benmills/vimux'
" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
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
" registers
Plug 'tversteeg/registers.nvim', { 'branch': 'main' }
" search
Plug 'dyng/ctrlsf.vim'
" refactor
Plug 'terryma/vim-multiple-cursors'
" prettier
Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
let g:prettier#autoformat = 0
"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
let g:prettier#config#tab_width = '2'
let g:fuzzy_rootcmds = ['git']
Plug 'w0ng/vim-hybrid'

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

tmap <C-o> <C-\><C-n>
call plug#end()

syntax on
"set termguicolors
set cursorline
set background=light
"set background=dark
colorscheme hybrid_material

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

let g:ale_elixir_elixir_ls_release = expand("/Users/arkadiuszplichta/.elixir_ls/rel")
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

function! PutTermPanel(buf, side, size) abort
  " new term if no buffer
  if a:buf == 0
    term
  else
    execute "sp" bufname(a:buf)
  endif
  " default side if wrong argument
  if stridx("hjklHJKL", a:side) == -1
    execute "wincmd" "J"
  else
    execute "wincmd" a:side
  endif
  " horizontal split resize
  if stridx("jkJK", a:side) >= 0
    if ! a:size > 0
      resize 6
    else
      execute "resize" a:size
    endif
    return
  endif
  " vertical split resize
  if stridx("hlHL", a:side) >= 0
    if ! a:size > 0
      vertical resize 6
    else
      execute "vertical resize" a:size
    endif
  endif
endfunction

function! s:ToggleTerminal(side, size) abort
  let tpbl=[]
  let closed = 0
  let tpbl = tabpagebuflist()
  " hide visible terminals
  for buf in filter(range(1, bufnr('$')), 'bufexists(bufname(v:val)) && index(tpbl, v:val)>=0')
    if getbufvar(buf, '&buftype') ==? 'terminal'
      silent execute bufwinnr(buf) . "hide"
      let closed += 1
    endif
  endfor
  if closed > 0
    return
  endif
  " open first hidden terminal
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)<0')
    if getbufvar(buf, '&buftype') ==? 'terminal'
      call PutTermPanel(buf, a:side, a:size)
      return
    endif
  endfor
  " open new terminal
  call PutTermPanel(0, a:side, a:size)
endfunction

" Toggle terminal - bottom
nnoremap <silent> <c-`> :call <SID>ToggleTerminal('J', 6)<CR>

" Toggle terminal - right
nnoremap <silent> yo<c-t> :call <SID>ToggleTerminal('L', 60)<CR>

tnoremap <Esc> <C-\><C-n>
