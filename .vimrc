" Global Switcher {{{
"   let g:keep_trailing_whitespace = 1
let g:support_python = 1
let g:support_php = 1
let g:support_less_sass = 1
let g:support_coffee = 1
let g:support_markdown = 1
let g:support_liquid_haml = 1
let g:support_cucumber = 1
let g:support_ruby_rails = 1
" }}}

" Function and Command {{{

" return OS type 
function! MySys()
  if has("win16")||has("win32")||has("dos")||has("dos16")||has("dos32")||has("win64")||has("win95")
    return "windows"
  elseif has("unix")
    return "linux"
  endif
endfunction

" check required folders needed by this vimrc , if not exists,create
function! EnsureDirExists (dir)
  if !isdirectory(a:dir)
    if exists("*mkdir")
      call mkdir(a:dir,'p')
      echo "Created directory: " . a:dir
    else
      echo "Please create directory: " . a:dir
      !cmd
    endif
  endif
endfunction

" dealing with adding <a> tag between <li> tag,all must be in one line
function! Lia()
  s/li>\(.*\)<\/li/li><a>\1<\/a><\/li/g
endfunction
command! Lia call Lia() " no range around error 

" Strip whitespace 
function! StripTrailingWhitespace()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " do the business:
  %s/\s\+$//e
  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" }}}

"  Pre-setting {{{
if MySys() == "windows"
  set shell=/bin/sh
  " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
  " across (heterogeneous) systems easier.
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif


" no vi-compatible
set nocompatible

" setting for vundle
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
filetype off " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" }}}

" Bundle Start {{{
" let Vundle manage Vundle, required! 
Bundle 'gmarik/vundle'

" make vim easy to use {{{

Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
" bringing Sublime Text's awesome multiple selection feature into Vim
Bundle 'terryma/vim-multiple-cursors'
" Code and files fuzzy finder
Bundle 'kien/ctrlp.vim'
" Airline
Bundle 'bling/vim-airline'
" Surround
Bundle 'tpope/vim-surround'
" undo mantainment
Bundle 'sjl/gundo.vim'
" intelligently toggling line numbers.
Bundle 'myusuf3/numbers.vim'
" Autoclose
Bundle 'tpope/vim-unimpaired'
" Indent text object
Bundle 'nathanaelkane/vim-indent-guides'
" vim sessions
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-session'
Bundle 'danro/rename.vim'
Bundle 'Lokaltog/vim-easymotion'
" Colorscheme
Bundle 'altercation/vim-colors-solarized'
" makes GVim-only colorschemes Just Work in terminal Vim
Bundle 'godlygeek/csapprox'
" colorshcemes collection
Bundle 'flazz/vim-colorschemes'
" handle gist
Bundle 'mattn/gist-vim'
" Tabularize
Bundle 'godlygeek/tabular'
" file manager
Bundle 'mbbill/VimExplorer'
" Search results counter
Bundle 'IndexedSearch'
" Produce increasing/decreasing columns of numbers, dates, or daynames
Bundle 'VisIncr'
" handy for varient words replacement
Bundle 'tpope/vim-abolish.git'
" Adjust font-size
Bundle 'drmikehenry/vim-fontsize'

" }}}
" program fun and language support {{{

" Better file browser
" Code commenter
Bundle 'scrooloose/nerdcommenter'
" Class/module browser
Bundle 'majutsushi/tagbar'
" write html ease
Bundle 'mattn/emmet-vim'
" Python mode (indentation, doc, refactor, lints, code checking, motion and
" Snippets manager (UltiSnips), and snippets repo
Bundle 'SirVer/ultisnips'
Bundle 'maple-leaf/UltiSnips-ext'
" Autocompletion
Bundle 'Shougo/neocomplete.vim'
" Git integration
Bundle 'tpope/vim-fugitive'
" code control of git, mercurial, darcs, bazaar, subversion, cvs, rcs, fossil, accurev, perforce
Bundle 'mhinz/vim-signify'
" html5 syntax
Bundle 'othree/html5.vim'
" Python and PHP Debugger
" Bundle 'fisadev/vim-debug.vim'
" XML/HTML tags navigation
Bundle 'matchit.zip'
" Syntax checking for lots of language
Bundle 'scrooloose/syntastic'
" HTTP,OAuth.. protocol supporter and http,xml,json...parser
Bundle 'mattn/webapi-vim'
Bundle 'aperezdc/vim-template'
Bundle 'pangloss/vim-javascript'
Bundle 'amirh/HTML-AutoCloseTag'
Bundle 'elzr/vim-json'
if exists('g:support_python')
" operators, highlighting, run and ipdb breakpoints)
Bundle 'klen/python-mode'
" Python code checker
Bundle 'pyflakes.vim'
endif
if exists('g:support_php')
" php tools collection
Bundle 'spf13/PIV'
Bundle 'arnaud-lb/vim-php-namespace'
" php template engine
Bundle 'beyondwords/vim-twig'
endif
" Vastly improved Javascript indentation and syntax support in Vim.
if exists('g:support_coffee-script')
Bundle 'kchmck/vim-coffee-script'
endif
if exists('g:support_liquid_haml')
Bundle 'tpope/vim-haml'
" Liquid markup language syntax support
Bundle 'tpope/vim-liquid'
endif
if exists('g:support_markdown')
Bundle 'tpope/vim-markdown'
endif
if exists('g:support_ruby_rails')
Bundle 'tpope/vim-rails'
endif
if exists('g:support_less_sass')
" less syntax
Bundle 'groenewege/vim-less'
" scss syntax
Bundle 'cakebaker/scss-syntax.vim'
endif
if exists('g:support_cucumber')
Bundle 'tpope/vim-cucumber'
Bundle 'quentindecock/vim-cucumber-align-pipes'
endif

" }}}

" }}}

" Env-setting {{{
"use dark solarized theme
if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
  set background=dark 
  " let g:solarized_termcolors=16
  let g:solarized_termcolors=256
  let g:solarized_termtrans=1
  let g:solarized_contrast="normal"
  let g:solarized_visibility="normal"
  color solarized             " Load a colorscheme
endif


command! -nargs=1 Mkdir call EnsureDirExists(<f-args>)

if MySys()=="windows"
  set guifont=Monaco:h9:b
elseif MySys() =="linux"
  set guifont=Mono\ 12
endif
" global variables define
" set $VIMFILES
" if MySys()=="windows"
" let $VIMFILES = $VIM.'/vimfiles'
" elseif MySys() =="linux"
" let $VIMFILES = $HOME.'/.vim'
" endif
"set $VIMBUNDLE
let $VIMBUNDLE=$HOME.'/.vim/bundle/'
" set $MYVIMRC
" if MySys()=="windows"
" let $MYVIMRC = $VIM.'/vimrc-git/.vimrc'
" elseif MySys() =="linux"
" let $MYVIMRC = $HOME.'/vimrc-git/.vimrc'
" endif
" set doc folder
" let $doc=$VIMFILES.'/doc'
" set path for find command
set path=~/
set rtp+=$VIMFILES

" create folder to store sessions
call EnsureDirExists($HOME . '/vim/sessions/')
" change path to work folder at startup
" :cd d:\tang\source_code\projects

" maximum window size
if MySys() == "windows"
  au GUIEnter * simalt ~x
elseif MySys() == "linux"
  set lines=99 columns=999
endif


" Formatting {
" language and encoding stuff
let $LANG ="en"
set helplang="en,zh-cn"
scriptencoding utf-8
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1
if has("win32")
  set fileencoding=chinese
else
  set fileencoding=utf-8
endif

"set nowrap                      " Do not wrap long lines
set wrap lbr                    " wrap long lines between words
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
"set matchpairs+=<:>             " Match, to be used with %
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,go,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> if !exists('g:keep_trailing_whitespace') | call StripTrailingWhitespace() | endif
autocmd FileType go autocmd BufWritePre <buffer> Fmt
autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
autocmd FileType haskell setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType html,xml,xhtml set fdm=indent | set fdl=3
" preceding line best in a plugin but here for now.

autocmd BufNewFile,BufRead *.coffee set filetype=coffee

" Workaround vim-commentary for Haskell
autocmd FileType haskell setlocal commentstring=--\ %s
" Workaround broken colour highlighting in Haskell
autocmd FileType haskell setlocal nospell

" }


" Silent, no beep or flash when error occur
set noerrorbells visualbell t_vb=
if has('autocmd')
  augroup MyAutoCommands
    " Clear old autocmds in group
    autocmd!

    " File types
    autocmd BufRead,BufNewFile *.haml setfiletype haml
    " autocmd BufRead,BufNewFile *.sass,*.scss setfiletype sass
    autocmd BufRead,BufNewFile config.ru,Gemfile,Isolate setfiletype ruby
    autocmd BufRead,BufNewFile *.liquid,*.mustache setfiletype liquid

    " Ruby files
    autocmd FileType cucumber set sw=2 ts=2 sts=2 et
    autocmd FileType ruby,eruby, set sw=2 ts=2 sts=2 et
    autocmd FileType ruby,eruby, imap <buffer> <CR> <C-R>=RubyEndToken()<CR>

    autocmd FileType ruby nnoremap <Leader>d orequire "ruby-debug"; debugger; ""<Esc>
    autocmd FileType ruby nnoremap <Leader>D Orequire "ruby-debug"; debugger; ""<Esc>

    " HTML/HAML
    " autocmd FileType html,haml set shiftwidth=2 softtabstop=2 expandtab

    autocmd FileType haml nnoremap <Leader>d orequire "ruby-debug"; debugger; ""<Esc>
    autocmd FileType haml nnoremap <Leader>D Orequire "ruby-debug"; debugger; ""<Esc>

    " Javascript
    " autocmd FileType javascript set shiftwidth=2 softtabstop=2 expandtab

    " CSS
    " autocmd FileType sass,css set shiftwidth=2 softtabstop=2 expandtab

    " Other langs
    autocmd FileType python,php set shiftwidth=4 softtabstop=4 expandtab

    " Coffee
    autocmd FileType coffee set shiftwidth=2 softtabstop=2 expandtab

    " Vim files
    autocmd FileType vim set shiftwidth=2 softtabstop=2 expandtab
    " autocmd BufWritePost .vimrc source $MYVIMRC

    " Auto-wrap text in all buffers
    " autocmd BufRead,BufNewFile * set formatoptions+=t
    " silent
    autocmd GUIEnter * set visualbell t_vb=
    " short of autocmd FileType python setlocal colorcolumn=80
    au FileType python setl cc=80
    " set highlight style
  augroup END

endif

if(!has('gui_running'))
  au ColorScheme * hi CursorLine   cterm=NONE ctermbg=darkgray ctermfg=NONE guibg=darkgray guifg=NONE
endif
" hide the mouse pointer while typing
set mousehide

" kill GUI-vim's toolbar and menus
set guioptions=c

"get that filetype stuff happening
filetype plugin on
filetype indent on
"turn on that syntax highlighting
syntax on

" make buffer files can hidden
set hidden

" set folder method
set fdm=marker
au FileType html setl fdm=indent
au FileType xhtml setl fdm=indent
" don't update the display while executing macros
set lazyredraw

" show what mode i'm in
set showmode

set cul " highlight current line
highlight clear SignColumn      " SignColumn should match background for
" things like vim-gitgutter, vim-signify

highlight clear LineNr          " Current line number row will have same background color in relative mode.
" Things like vim-gitgutter or vim-signify will match LineNr highlight
"highlight clear CursorLineNr    " Remove highlight color from current line number

" backup and swapfile
call EnsureDirExists($HOME . '/vim/tmp/backup/')
call EnsureDirExists($HOME . '/vim/tmp/swap/')
set backupdir=~/vim/tmp/backup//
set directory=~/vim/tmp/swap//
" set nobackup
" set nowb
" set noswapfile

if has('statusline')
  set laststatus=2

  " set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]
  " Broken down into easily includeable segments
  set statusline=%<%f\                     " Filename
  set statusline+=%w%h%m%r                 " Options
  set statusline+=%{fugitive#statusline()} " Git Hotness
  set statusline+=\ [%{&ff}/%Y]            " Filetype
  set statusline+=\ [%{getcwd()}]          " Current dir
  set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

" timeout used while waiting for user input on a multi-keyed macro of while
" just sitting and waiting foranother key to be preesed measured in
" milliseconds.
set timeoutlen=500
set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set showmatch                   " Show matching brackets/parenthesis

" keep some stuff in the histroy
set history=100

if has('cmdline_info')
  set ruler                   " Show the ruler
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
  set ch=2 " set command line has two line
  set showcmd  " Show partial commands in status line and
  " Selected characters/lines in visual mode
endif

" display line number,absolute line number
" set nu!
set relativenumber " no absolute line number

" These comands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" Incrementally match the search
set incsearch
set ignorecase    " Case insensitive search
set smartcase     " Case sensitive when uc present
" set ignore file extension of wildmenu, won't list when using filename
" completion
" Enable enhanced command-line completion. Presumes you have compiled
" with +wildmenu.  See :help 'wildmenu'
set wildmenu
set wildignore+=*.a,*.o,.DS_Store,.git,.hg,.svn,*~,*.swp,*.tmp
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too

set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor

set foldenable                  " Auto fold code
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" detect which style of file
let g:C_Styles = { '*.c,*.h' : 'C', '*.cc,*.cpp,*.hh' : 'CPP' }


" }}}

" Mapping {{{

let mapleader = ","

""""""""""""""""""""""""""""""""""""""""
" normal mapping {
""""""""""""""""""""""""""""""""""""""""" 
" python compile 
no <F5> :w<cr>:!python %<cr>

" arrow key
" move current up
no <up> ddkP
" move current down
no <down> ddp
" move to next tab
no <right> :tabnext<CR>
" move to prev tab
no <left> :tabprevious<CR>

" get a empty line below
no <M-o> o<ESC>k
" get a empty line above
no gO O<ESC>j

" open a new gvim instance silent 
no ,nv :silent !gvim<CR>

" Toggle paste mode
"nmap  <leader>p :set invpaste:set paste?

" save current file or all files
no ss :w<CR>
no sa :wa<CR>

" previous file 
nmap  <leader>m :bp<cr>

" next file 
nmap  <leader>n :bn<cr>

" Turn on that stupid highlight search
nmap  <leader>i :set invhls<cr>
" Turn off that stupid highlight search
nmap  <leader>H :set hls<cr>

" Set up retabbing on a source file
nmap  <leader>rr :1,$retab<cr>

" cd to the directory containing the file in the buffer
nmap  <leader>cd :lcd %:h<cr>
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h
" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" get path of current file at cmd line
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Make the directory that contains the file in the current buffer.
" This is useful when you edit a file in a directory that doesn't
" (yet) exist
" nmap  <leader>md :!mkdir name %:p:h

" Let's make it easy to edit this file (mnemonic for the key sequence is
" 'e'dit 'v'imrc)
nmap <silent> <leader>ev :sp $MYVIMRC<cr>

" And to source this file as well (mnemonic for the key sequence is
" 's'ource 'v'imrc)
nmap <silent> <leader>sv :so $MYVIMRC<cr>
" windows_control {
"spilt window horizontal
noremap <silent> <leader>w :sp<cr>
"spilt window vertical
noremap <silent> <leader>W :vsp<cr>
" Move the cursor to the window left of the current one
noremap <silent> <leader>h :wincmd h<cr>
" Move the cursor to the window below the current one
noremap <silent> <leader>j :wincmd j<cr>
" Move the cursor to the window above the current one
noremap <silent> <leader>k :wincmd k<cr>
" Move the cursor to the window right of the current one
noremap <silent> <leader>l :wincmd l<cr>
" Close the current window
noremap <silent> <leader>C :close<cr>
" Close the window below this one
noremap <silent> <leader>Cj :wincmd j<cr>:close<cr>
" Close the window above this one
noremap <silent> <leader>Ck :wincmd k<cr>:close<cr>
" Close the window to the left of this one
noremap <silent> <leader>Ch :wincmd h<cr>:close<cr>
" Close the window to the right of this one
noremap <silent> <leader>Cl :wincmd l<cr>:close<cr>
" Maximum the current window
noremap <silent> <leader>M :wincmd <C-_><cr>
" balance all windows 
noremap <silent> <leader>B :wincmd <C-=><cr>
" Move the current window to the right of the main Vim window
noremap <silent> <leader>ml <C-W>L
" Move the current window to the top of the main Vim window
noremap <silent> <leader>mk <C-W>K
" Move the current window to the left of the main Vim window
noremap <silent> <leader>mh <C-W>H
" Move the current window to the bottom of the main Vim window
noremap <silent> <leader>mj <C-W>J
" Adjust viewports to the same size
map <Leader>= <C-w>=
" Easier horizontal scrolling
map zl zL
map zh zH
" }

" quit current window confirmly
noremap <silent> <leader>qc :q!<CR>

" quit all windows confirmly
noremap <silent> <leader>qa :qa!<CR>
" Switch tabs easily {
map <A-H> gT
map <A-L> gt
map <A-1>  1gt
map <A-2>  2gt
map <A-3>  3gt
map <A-4>  4gt
map <A-5>  5gt
map <A-6>  6gt
map <A-7>  7gt
map <A-8>  8gt
map <A-9>  9gt
map <A-0> 10gt
" }

" Code folding options {
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>
" }

ino <C-Q> <ESC>V
ino <m-k> <ESC>k==i
ino ;; <ESC>
vno ;; <ESC>
nno ;; <ESC>
" filename completion
ino <c-j> <c-x><c-f>
" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" some mappings are useful for copying the file name to the clipboard. {
" Convert slashes to backslashes for Windows.
if has('win32')
  " only file name with extension
  nmap ;cs :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
  " full path 
  nmap ;cl :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>

  " This will copy the path in 8.3 short format, for DOS and Windows 9x
  nmap ;c8 :let @*=substitute(expand("%:p:8"), "/", "\\", "g")<CR>
else
  nmap ;cs :let @*=expand("%")<CR>
  nmap ;cl :let @*=expand("%:p")<CR>
endif
" }
""""""""""""""""""""""""""""""""""""""""""
"}	
""""""""""""""""""""""""""""""""""""""""""
" Operator-Pending Mapping , can work with other operators{{{
" select contents in next parentheses after cusor(examples->cin:delete contents and put
" you in insert mode ,din:delete contents only) , int is not perfect yet,the
" curso must locate before end tag,else '<a></a>f<b>contents</b>',cursor before </a>
" will delete <a></a>,not contents between 'b' tag
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap in[ :<c-u>normal! f[vi[<cr>
onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap int :<c-u>normal! f<vit<cr>
" }}}
" }}}

" Plugins {{{

    " PIV {{{
        let g:DisableAutoPHPFolding = 0
        let g:PIVAutoClose = 0
    " }}}

    " Misc {{{
        let g:NERDShutUp=1
        let b:match_ignorecase = 1
    " }}}

    " Ctags {{{
        set tags=./tags;/,~/.vimtags

        " Make tags placed in .git/tags file available in all levels of a repository
        let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
        if gitroot != ''
            let &tags = &tags . ',' . gitroot . '/.git/tags'
        endif
    " }}}

    " AutoCloseTag {{{
        " Make it so AutoCloseTag works for xml and xhtml files as well
        au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
        nmap <Leader>ac <Plug>ToggleAutoCloseMappings
    " }}}

    " NerdTree {{{
        map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
        map <leader>n :NERDTree<CR>
        nmap <leader>nf :NERDTreeFind<CR>

        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=1
        let NERDTreeMouseMode=2
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
        let g:nerdtree_tabs_open_on_gui_startup=0
    " }}}

    " Tabularize {{{
        nmap <Leader>a& :Tabularize /&<CR>
        vmap <Leader>a& :Tabularize /&<CR>
        nmap <Leader>a= :Tabularize /=<CR>
        vmap <Leader>a= :Tabularize /=<CR>
        nmap <Leader>a: :Tabularize /:<CR>
        vmap <Leader>a: :Tabularize /:<CR>
        nmap <Leader>a:: :Tabularize /:\zs<CR>
        vmap <Leader>a:: :Tabularize /:\zs<CR>
        nmap <Leader>a, :Tabularize /,<CR>
        vmap <Leader>a, :Tabularize /,<CR>
        nmap <Leader>a,, :Tabularize /,\zs<CR>
        vmap <Leader>a,, :Tabularize /,\zs<CR>
        nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    " }}}

    " vim-session {{{
        " If you don't want help windows to be restored:
        set sessionoptions-=help
        let g:session_directory = '~/.vimsessions'
        let g:session_autosave = 'yes'
        let g:session_autoload = 'no'
        let g:session_default_name = "last"

        no ms :SaveSession 
        no \s :OpenSession 
    " }}}

    " JSON {{{
        "nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
    " }}}

    " PyMode {{{
        let g:pymode_lint_checker = "pyflakes"
        let g:pymode_utils_whitespaces = 0
        let g:pymode_options = 0
    " }}}

    " ctrlp {{{
        let g:ctrlp_working_path_mode = 'ra'
        " use PageUp and PageDown more often than \<C-f\> and \<C-B\>
        nnoremap <silent> <C-b> :CtrlPBuffer<CR>
        nnoremap <silent> <C-m> :CtrlPMRU<CR>
        let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:50'
        let g:ctrlp_use_caching = 1
        let g:ctrlp_clear_cache_on_exit = 0
        let g:ctrlp_show_hidden = 0
        let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.git$\|\.hg$\|\.svn$',
            \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

        " On Windows use 'dir' as fallback command.
        if has('win32') || has('win64')
            let g:ctrlp_user_command = {
                \ 'types': {
                    \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                \ },
                \ 'fallback': 'dir %s /-n /b /s /a-d'
            \ }
        else
            let g:ctrlp_user_command = {
                \ 'types': {
                    \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                \ },
                \ 'fallback': 'find %s -type f'
            \ }
        endif
    "}}}

    " TagBar {{{
        nnoremap <silent> <leader>tt :TagbarToggle<CR>

        " If using go please install the gotags program using the following
        " go install github.com/jstemmer/gotags
        " And make sure gotags is in your path
        let g:tagbar_type_go = {
            \ 'ctagstype' : 'go',
            \ 'kinds'     : [  'p:package', 'i:imports:1', 'c:constants', 'v:variables',
                \ 't:types',  'n:interfaces', 'w:fields', 'e:embedded', 'm:methods',
                \ 'r:constructor', 'f:functions' ],
            \ 'sro' : '.',
            \ 'kind2scope' : { 't' : 'ctype', 'n' : 'ntype' },
            \ 'scope2kind' : { 'ctype' : 't', 'ntype' : 'n' },
            \ 'ctagsbin'  : 'gotags',
            \ 'ctagsargs' : '-sort -silent'
            \ }
    "}}}

    " PythonMode {{{
        " Disable if python support not present
        if !has('python')
            let g:pymode = 1
        endif
    " }}}

    " Fugitive {{{
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
        nnoremap <silent> <leader>gr :Gread<CR>
        nnoremap <silent> <leader>gw :Gwrite<CR>
        nnoremap <silent> <leader>ge :Gedit<CR>
        nnoremap <silent> <leader>gg :SignifyToggle<CR>
    "}}}

    " neocomplete {{{
            let g:acp_enableAtStartup = 0
            let g:neocomplete#enable_at_startup = 1
            let g:neocomplete#enable_smart_case = 1
            let g:neocomplete#enable_auto_delimiter = 1
            let g:neocomplete#max_list = 15
            let g:neocomplete#force_overwrite_completefunc = 1

            " Define dictionary.
            let g:neocomplete#sources#dictionary#dictionaries = {
                        \ 'default' : '',
                        \ 'vimshell' : $HOME.'/.vimshell_hist',
                        \ 'scheme' : $HOME.'/.gosh_completions'
                        \ }

            " Define keyword.
            if !exists('g:neocomplete#keyword_patterns')
                let g:neocomplete#keyword_patterns = {}
            endif
            let g:neocomplete#keyword_patterns['default'] = '\h\w*'

            " Plugin key-mappings {{{

                inoremap <expr><C-g> neocomplete#undo_completion()
                inoremap <expr><C-l> neocomplete#complete_common_string()
                inoremap <expr><CR> neocomplete#complete_common_string()

                " <TAB>: completion.
                inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
                inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

                " <CR>: close popup
                " <s-CR>: close popup and save indent.
                inoremap <expr><s-CR> pumvisible() ? neocomplete#close_popup()"\<CR>" : "\<CR>"
                inoremap <expr><CR> pumvisible() ? neocomplete#close_popup() : "\<CR>"

                " <C-h>, <BS>: close popup and delete backword char.
                inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
                inoremap <expr><C-y> neocomplete#close_popup()
            " }}}

            " Enable omni completion.
            autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
            autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
            autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
            autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
            autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
            autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

            " Haskell post write lint and check with ghcmod
            " $ `cabal install ghcmod` if missing and ensure
            " ~/.cabal/bin is in your $PATH.
            if !executable("ghcmod")
                autocmd BufWritePost *.hs GhcModCheckAndLintAsync
            endif

            " Enable heavy omni completion.
            if !exists('g:neocomplete#sources#omni#input_patterns')
                let g:neocomplete#sources#omni#input_patterns = {}
            endif
            let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
            let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
            let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
            let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
            let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

    " }}}

    " UltiSnips {{{
    let g:UltiSnipsExpandTrigger = '<c-k>'
    let g:UltiSnipsJumpForwardTrigger = '<a-j>'
    let g:UltiSnipsSnippetsDir = '~/.vim/bundle/UltiSnips-ext/UltiSnips/'
    let g:UltiSnipsEditSplit = 'horizontal'
    let g:UltiSnipsJumpBackwardTrigger = '<a-k>'
    " }}}

    " gundo {{{
        nnoremap <Leader>u :GundotreeToggle<CR>
    " }}}

    " indent_guides {{{
        if !exists('g:spf13_no_indent_guides_autocolor')
            let g:indent_guides_auto_colors = 1
        else
            " For some colorschemes, autocolor will not work (eg: 'desert', 'ir_black')
            autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#212121 ctermbg=3
            autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#404040 ctermbg=4
        endif
        let g:indent_guides_start_level = 2
        let g:indent_guides_guide_size = 1
        let g:indent_guides_enable_on_vim_startup = 1
    " }}}

    " vim-airline {{{
        " Set configuration options for the statusline plugin vim-airline.
        " Use the powerline theme and optionally enable powerline symbols.
        " To use the symbols , , , , , , and .in the statusline
        " segments add the following to your .vimrc.before.local file:
        "   let g:airline_powerline_fonts=1
        " If the previous symbols do not render for you then install a
        " powerline enabled font.
        let g:airline_theme = 'powerlineish'
        if !exists('g:airline_powerline_fonts')
            " Use the default set of separators with a few customizations
            let g:airline_left_sep='›'  " Slightly fancier than '>'
            let g:airline_right_sep='‹' " Slightly fancier than '<'
        endif
        let g:airline#extensions#bufferline#enabled = 0
    " }}}

    " vim-signify {{{
    " }}}

    "vim-fontsize {{{
        nmap <silent> <C-Up>  <Plug>FontsizeInc
        nmap <silent> <C-Down>  <Plug>FontsizeDec
    "}}}

    " Easymotion {{{
    map ; <Plug>(easymotion-prefix)
    " }}}

    "syntastic {{{
    " sass syntax checking is so slow, so don't check it auto
    let g:syntastic_mode_map = {
                \ "mode": "active",
                \ "passive_filetypes": ["haml", "scss", "sass"] }
    no <F10> :SyntasticCheck<cr>
    "}}}

" }}}

" Abbreviation And Typo-correct {{{
  iabbr ture true
  iabbr flase false

" }}}

