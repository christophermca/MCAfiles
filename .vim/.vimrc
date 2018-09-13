" AUTHOR: Christopher MCA
" Version: 1.0
" Sections:
"
" Plugins
"=============================================================================
" Vim >= 7.0 specific colors
if !has('packages')
  source ~/.vundle
endif

" compatibility

" SETUP {{{
"=====================================================================
" GENERAL {{{
set nocp
set fileformat=unix
let g:vim_json_syntax_conceal=0
set textwidth=80
set formatoptions=cq
set backspace=indent,eol,start


" node suffix help
set suffixesadd=.coffee,.js,.styl,.css
filetype plugin indent on
syntax enable " enable syntax processing
set autoindent

"when saving vimrc reload the source

  " fix slow escape in iterm2
  set ttimeout
  set notimeout
  set ttimeoutlen=20
"}}}
"}}}
" AUTOCMDS {{{
set autoread
autocmd BufWritePre * :silent! :call <SID>Respace()

augroup checkfileupdate
  autocmd WinEnter * :silent :checktime
augroup END

augroup vimrc_autocmds
  autocmd!
  autocmd BufEnter * match ErrorMsg /\%120v.\+/
augroup END

augroup reload_vimrc
  autocmd!
  autocmd bufwritepost $myvimrc source $myvimrc
augroup end

augroup FiletypeGroup
  autocmd!
  au bufread,bufnewfile *.cson set filetype=coffee
  au bufread,bufnewfile *.json set filetype=json
augroup END
"}}}
" COLORS AND FONTS {{{
"=====================================================================
set t_Co=256
if &term =~ '256color'
  set t_ut=
endif
set background=dark
colorscheme speyside

" choose font by gui
if has("gui_running")
if has("gui_gtk2")
  set guifont=Inconsolata\ 12
elseif has("gui_macvim")
  set guifont=Menlo\ Regular:h12
elseif has("gui_win32")
  set guifont=Consolas:h10:w4:cANSI
endif
endif

" }}}
" VIM UI {{{
"=====================================================================
" error notification {{{
set visualbell " set error flashing
set noerrorbells " no beeping
"}}}
" splits {{{
set splitbelow
set splitright
"}}}
" backups {{{
set nobackup " No backup files
set nowritebackup " Only in case you don't want a backup file while editing
set noswapfile " No swap files
"}}}
" general {{{
set cursorline
"set lazyredraw " Redraw only when we need to
set viewoptions=folds,options,cursor,unix,slash " Better Unix Windows compatibility
set virtualedit=all " Allow for cursor beyond last character
set history=1000 " Store a ton of history (default is 20)
set hidden " Allow buffer switching without saving
set confirm " Confirm if you want to save
set tabpagemax=15 " Only show 15 page tabs
set showmode " Display the current mode
set linespace=0 " No extra spaces between rows
set nowrap " Do not wrap long lines
set scrolloff=1 " Minimum lines to keep above and below cursor
set ttyscroll=3 " Workaround for gvim screen redraw issues
"}}}
" window {{{
" gui {{{
" ****************
" go: GUI OPTIONS
" +: show
" -: hide
" ****************
set go-=T " Toolbar
set go-=m " Menu
set go-=l " Hide left sroll bar
set go-=L " Hide left scroll bar in split
set go-=R " Hide right scroll bar
set go-=r " Hide right scroll bar in split
"}}}
" size {{{
if has("gui_running")
  " GUI is running or is about to start.
  set lines=999 columns=999
endif

" For windows - sets the window to max size
if has("gui_running")
  if has("gui_win32")
    augroup GUIEnter * simalt ~x
  endif
endif
"}}}
"}}}
" spaces & tabs {{{
set tabstop=2 " Number of visual spaces per tab
set shiftwidth=2
set softtabstop=2 " Number of spaces in tab when editing
set expandtab " Tabs are spaces

"Show hidden chars
set list listchars=tab:»¬,trail:·
"}}}
" status bar + command line {{{
" ****************
set showcmd " Show command line in bottom bar
set wildmenu " Visual autocomplete for command menu

highlight Visual guibg=#333345

if has('statusline')
  set laststatus=2
  set statusline+=%{fugitive#statusline()} " Git status (courtesy of fugitive)

  " Broken down into easily includeable segments
  set statusline=%f%<\ " Filename
  set statusline+=[%{&ff}/%Y]\ " Filetype
  set statusline+=\[%{getcwd()}]%= " Current dir
  set statusline+=%w%h%m%r\ " Options
  set statusline+=%<%-14(%l,%c%V%)\ %p%% " Right aligned file nav info ruler
endif
"}}}
"line numbers {{{
set number " show line numbers
set nuw=4
"}}}
" mouse {{{
set mouse=a " Automatically enable mouse usage
set mousehide " Hide the mouse cursor while typing
"}}}
" searching {{{
set ic " Ignorecase
set smartcase
set incsearch " Search as characters are entered
set hlsearch " Highlight matches
set magic
"}}}
" folding {{{
" ****************
set foldenable " Enable folding
set foldmethod=indent
set foldlevel=99
"set foldlevelstart=11 " Open mast folds by default
"set foldnestmax=10 " 10 nested fold max

let g:SimpylFold_docstring_preview = 1
"}}}
"}}}
" MAPPING {{{
"=====================================================================

" ____Leader mappings
let mapleader="\<Space>"

" __Directory
" Change directory to current edited files directory
nmap <leader>cd :cd %:p:h<CR>

" ____Resizing
nmap <tab>h :vert res -10<CR>
nmap <tab>l :vert res +10<CR>
nmap <tab>k :resize +10<CR>
nmap <tab>j :resize -10<CR>


" Tab shortcuts
nmap <leader>nt :tabnew<CR>

" Close tab
nmap <leader>xt :tabc<CR>

" View Buffer list
nnoremap <leader>l :ls<CR>:b<space>

" Quick change directory

"JSON prettyify and validate
map <leader>jn :%!python3 -m json.tool<CR>

map <leader>de :'<,'>!python -m base64 -d<CR>

" Searching
nnoremap \<leader> :nohlsearch<CR>

" ****************
" X11 terminal copy/paste
" ****************

" Copy/paste to system clipboard
vmap <leader>y "+y
vmap <leader>yy "+yy
vmap <leader>Y "+Y
vmap <leader>yw "+yw
vmap <leader>yb "+yb
vmap <leader>D "+D
vmap <leader>p "+p
vmap <leader>P "+P

nmap <leader>y "+y<cr>
nmap <leader>yy "+yy<cr>
nmap <leader>Y "+Y<cr>
nmap <leader>yw "+yw<cr>
nmap <leader>yb "+yb<cr>
nmap <leader>D "+D<cr>
nmap <leader>p "+p<cr>
nmap <leader>P "+P<cr>

nmap <leader>cp :let @+ = expand("%")<cr>


map <leader>ag :Ack<Space>

" Saving
map <leader>w :w<CR>

" Vimrc
nmap <leader>vr :vsplit $MYVIMRC<CR>

" Edit colorscheme
nmap <leader>ec :call ToggleColorEdit()<CR>

" Coffee
nmap <leader>cc :CoffeeCompile<CR> " Compile

" Mocha
nmap <leader>r :call <SID>MochaTest()<CR>
nmap <leader>e :call <SID>MochaDebugTest()<CR>
nmap <leader>1 :call <SID>Console()<CR>

" ____SPLIT CONTROLS
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l
nmap <C-k> <C-w>k
nmap <C-j> <C-w>j

nnoremap - :call OpenView()<CR>
"}}}
" {{{ FUNCTIONS
function! <SID>Respace()
 let l = line(".")
 let c = col(".")
 %s#\s\+$##ge "Spacing at EOL
 nohlsearch
 call cursor(l, c)
endfunction

function! <SID>Console()
:!
endfunction

function! <SID>MochaDebugTest()
:!mocha debug %
endfunction


function! <SID>MochaTest()
:!clear && NODE_ENV=test mocha %
endfunction

function! ToggleColorEdit()
if !exists("g:editing_colors")
  let g:editing_colors = 1
  :vsplit ~/.vim/pack/colorschemes/start/speyside/colors/speyside.vim
  " :so $VIMRUNTIME/syntax/hitest.vim
  " :XtermColorTable
else
  unlet g:editing_colors
  :silent! :bd Highlight\ test | :bd */speyside.vim | :bd XtermColorTable
endif
endfunction

function! OpenView()
if isdirectory(expand("%:h"))
  :Ex %:h
else
  :Ex .
endif
endfunction
" }}}
" PLUGINS CONFIGS {{{
"=====================================================================
"
"{{{ Speyside - Coloscheme
let g:SpeysideLuminosity = 1

"}}}}

" AG - the silver searcher {{{
if executable('ag')
let g:ackprg = 'ag --vimgrep'
endif
" }}}

" NETRW {{{
let g:netrw_preview = 1
let g:netrw_liststyle = 0
let g:netrw_banner = 0
let g:netrw_localrmdir='rm -r'
" TODO explain what the arguments on below line stand for.
let g:netrw_bufsettings="noma nomod nonu nobl nowrap ro rnu"
" }}}

"Async Linting Engine (ALE) {{{
let g:ale_fixers = {
    \'stylus': ['stylint'],
    \'javascript': ['prettier', 'eslint'],
    \}
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

" Edit Error and Warning Highlighting
let g:ale_sign_warning='●'
hi ALEErrorSign ctermfg='red' ctermbg=none

let g:ale_sign_error='●'
hi ALEWarningSign ctermfg='yellow' ctermbg=none
"}}}

" speyside {{{
if maparg('<leader>gs', 'n') ==# ''
xmap <leader>gl  <plug>speyside
vmap <leader>gl  <plug>speyside
nmap <leader>gl  <plug>speyside
omap <leader>gl  <plug>speyside
endif
"}}}

" FZF {{{
set rtp+=/usr/local/opt/fzf
nmap <F7> :FZF <CR>

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
"}}}
"


" vim: fdm=marker foldlevelstart=0 foldlevel=0 foldminlines=1
