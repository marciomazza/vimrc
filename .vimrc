" Bootstrapped with http://vim-bootstrap.com/
" (https://github.com/avelino/vim-bootstrap)
if has('python3')
endif

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/grep.vim'
Plug 'vim-scripts/CSApprox'
Plug 'ntpeters/vim-better-whitespace'
Plug 'bogado/file-line'
Plug 'gu-fan/riv.vim'
Plug 'terryma/vim-expand-region'
Plug 'rickhowe/diffchar.vim'
Plug 'gaving/vim-textobj-argument'
Plug 'vim-scripts/gitignore'

"" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"" Color
Plug 'marciomazza/vim-brogrammer-theme'

"" for Python
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'alfredodeza/pytest.vim', { 'for': 'python' }
Plug 'mindriot101/vim-yapf', { 'for': 'python' }
Plug 'fisadev/vim-isort', { 'for': 'python' }
Plug 'hdima/python-syntax', { 'for': 'python' }
Plug 'ambv/black'

"" for Python and Javascript
Plug 'w0rp/ale'

"" Javascript
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'justinj/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'isruslan/vim-es6', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'posva/vim-vue'

"" HTML
Plug 'vim-scripts/HTML-AutoCloseTag', { 'for': ['html', 'jinja', 'htmldjango'] }
Plug 'hail2u/vim-css3-syntax', { 'for': ['html', 'jinja', 'htmldjango'] }
Plug 'gorodinskiy/vim-coloresque', { 'for': ['html', 'jinja', 'htmldjango', 'css', 'less', 'sass', 'scss'] }
Plug 'tpope/vim-haml', { 'for': ['haml', 'sass', 'scss'] }
Plug 'mattn/emmet-vim', { 'for': ['html', 'jinja', 'htmldjango'] }

"" Programming in general
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'
Plug 'luochen1990/rainbow'
Plug 'ervandew/supertab'
Plug 'majutsushi/tagbar', {'on': []}

call plug#end()

" Tagbar
"" hack by @magnunleno to replace
""     let g:airline#extensions#tagbar#enabled = 1
function! MyTagbarToggle()
  let g:airline#extensions#tagbar#enabled = 1
  call plug#load('tagbar')
  TagbarToggle
  let s:ext = {}
  let s:ext._theme_funcrefs = []
  function! s:ext.add_statusline_func(name) dict
    call airline#add_statusline_func(a:name)
  endfunction
  function! s:ext.add_statusline_funcref(function) dict
    call airline#add_statusline_funcref(a:function)
  endfunction
  function! s:ext.add_inactive_statusline_func(name) dict
    call airline#add_inactive_statusline_func(a:name)
  endfunction
  function! s:ext.add_theme_func(name) dict
    call add(self._theme_funcrefs, function(a:name))
  endfunction
  call airline#extensions#tagbar#init(s:ext)
  AirlineRefresh
endfunction
nnoremap <silent> <F4> :call MyTagbarToggle()<CR>
let g:tagbar_autoclose = 1
"" sort by position in file
let g:tagbar_sort = 0

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
""" show tabs
set list
set listchars=tab:>-

"" Map leader to ,
let mapleader=','

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Encoding
set ttyfast

"" Directories for swp files
set nobackup
set noswapfile

set fileformats=unix,dos,mac
set showcmd
set shell=/bin/sh

" Reload files from disk automatically
set autoread

" session management
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set ruler
set number
set relativenumber

let no_buffers_menu=1
set t_Co=256
" silent for the case when the plugin has not yet been installed
silent! colorscheme brogrammer

set mousemodel=popup
set nocursorline
set guioptions=egmrti
set gfn=Monospace\ 10

if has("gui_running")
  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
    set transparency=7
  endif
else
  let g:CSApprox_loaded = 1
  " Note that setting term=gnome-256color yields broken Ctrl-<Left> and Ctrl-<Right>
  set term=xterm-256color
endif

if &term =~ '256color'
  set t_ut=
endif

"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

" vim-airline
let g:airline_theme = 'powerlineish'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif
" in airline avoid delay when switching from insert to normal mode
" see https://github.com/bling/vim-airline/issues/124#issuecomment-22389800
" and see https://github.com/bling/vim-airline/wiki/FAQ#there-is-a-pause-when-leaving-insert-mode
set ttimeoutlen=50

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have these shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 40
let g:NERDTreeShowHidden = 1
let g:NERDTreeQuitOnOpen = 1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>
noremap <F3> :NERDTreeToggle<CR>

" grep.vim
nnoremap <silent> <leader>f :Rgrep<CR>
let Grep_Default_Options = '-IR'

" vimshell.vim
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_prompt =  '$ '

" terminal emulation
nnoremap <silent> <leader>sh :VimShellCreate<CR>

"*****************************************************************************
"" Functions
"*****************************************************************************
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" The PC is fast enough, do syntax highlight syncing from start
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync fromstart
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

"" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

set autoread
au FocusGained,BufEnter,BufWinEnter,CursorHold,CursorMoved * :checktime

"" xml extras
autocmd BufRead,BufNewFile *.zcml :set ft=xml
autocmd FileType xml :setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab

"" html
autocmd BufRead,BufNewFile *.zpt :set ft=html
autocmd FileType html :setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType htmldjango :setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType jinja :setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab

"" css
autocmd FileType css :setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab

"" less
autocmd FileType less :setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab

"" scss
autocmd FileType scss :setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab

"" python black
autocmd BufWritePre *.py execute ':Black'

"*****************************************************************************
"" Mappings
"*****************************************************************************
"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" Git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

" session management
nnoremap <leader>so :OpenSession
nnoremap <leader>ss :SaveSession
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

" ctrlp.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|tox)$'
let g:ctrlp_user_command = "find %s -type f | grep -Ev '"+ g:ctrlp_custom_ignore +"'"
let g:ctrlp_use_caching = 0
cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
noremap <leader>b :CtrlPBuffer<CR>
let g:ctrlp_map = '<leader>e'
let g:ctrlp_open_new_file = 'r'

" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"

" ALE
let g:ale_fix_on_save = 1
let g:ale_fixers = {'python': ['isort']}
let g:ale_pattern_options = {'ipython_log.py': {'ale_enabled': 0}}
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

noremap YY "+y<CR>
noremap P "+gP<CR>
noremap XX "+x<CR>

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

"" Buffer nav
noremap <S-Tab>   :bp<CR>
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>

noremap <Tab>     :bn<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>

"" Close buffer
noremap <leader>c :bd<CR>

"" Clear search highlight
nnoremap <silent> <leader><space> :noh<cr>

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Open current line on GitHub
noremap ,o :!echo `git url`/blob/`git rev-parse --abbrev-ref HEAD`/%\#L<C-R>=line('.')<CR> \| xargs open<CR><CR>

"" toggle spell check
map <F6> :syntax on<CR>:setlocal spell! spelllang=en_us<CR>
imap <F6> <C-o>:syntax on<C-o>:setlocal spell! spelllang=en_us<CR>

"*****************************************************************************
"" Custom add-on configs
"*****************************************************************************

" vim-python
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
      \ formatoptions+=croq softtabstop=4 smartindent
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

" jedi-vim
let g:jedi#popup_on_dot = 0
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "0"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#popup_on_dot = 1

" vim-airline
let g:airline#extensions#virtualenv#enabled = 1

let g:javascript_enable_domhtmlcss = 1

" hdima/python-syntax
" Full python Syntax highlighting
let g:python_highlight_all = 1

" supertab
let g:SuperTabDefaultCompletionType = "context"

" ntpeters/vim-better-whitespace
let g:strip_whitespace_on_save = 1

" vim-yapf
:nnoremap <leader>y :Yapf<cr>
:nnoremap <leader>k :Isort<cr>

" pytest.vim
"  TODO get back to this plugin and check if it can be useful
" Execute the tests
nmap <silent><Leader>tc <Esc>:Pytest class<CR>
nmap <silent><Leader>tm <Esc>:Pytest method<CR>
nmap <silent><Leader>tf <Esc>:Pytest file<CR>
nmap <silent><Leader>tt <Esc>:Pytest project<CR>
" cycle through test errors
nmap <silent><Leader>tn <Esc>:Pytest next<CR>
nmap <silent><Leader>tp <Esc>:Pytest previous<CR>
nmap <silent><Leader>te <Esc>:Pytest error<CR>

" rainbow
let g:rainbow_active = 1

" vim-autopep8
let g:autopep8_disable_show_diff = 1

" riv.vim
let g:riv_disable_folding = 1
let g:riv_auto_rst2html = 1
let g:riv_temp_path = '/tmp'

" vim-better-whitespace
let g:strip_whitespace_confirm = 0
let g:strip_whitelines_at_eof = 1

" vimdiff
"" ignore whitespace differences
set diffopt+=iwhite

let g:black_linelength = 79
