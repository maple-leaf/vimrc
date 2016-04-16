"Plugin 'Shougo/neocomplete.vim'
" macvim will catch dead abort, `brew unlink python` may work
" https://github.com/Valloric/YouCompleteMe/issues/8#issuecomment-34374807
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'maple-leaf/UltiSnips-ext'
Plugin 'tpope/vim-fugitive'
Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/nerdcommenter'

function! FrontEndSupport()
    Plugin 'pangloss/vim-javascript'
    Plugin 'heavenshell/vim-jsdoc'
    " write html ease
    Plugin 'mattn/emmet-vim'
    Plugin 'othree/html5.vim'
    " less syntax
    Plugin 'groenewege/vim-less'
    " scss syntax
    Plugin 'cakebaker/scss-syntax.vim'
    " react jsx support
    Plugin 'mxw/vim-jsx.git'
    " XML/HTML tags navigation
    Plugin 'matchit.zip'
    " javascript sematic complete, very slow....
    " Plugin 'ternjs/tern_for_vim'
endfunction
call FrontEndSupport()

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'd11wtq/ctrlp_bdelete.vim'
Plugin 'scrooloose/nerdtree'
" vim sessions
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'danro/rename.vim'
"Plugin 'godlygeek/tabular'
Plugin 'junegunn/vim-easy-align'
" Search results counter
Plugin 'IndexedSearch'
" Produce increasing/decreasing columns of numbers, dates, or daynames
Plugin 'VisIncr'
" grep tool
Plugin 'rking/ag.vim'
" bringing Sublime Text's awesome multiple selection feature into Vim
Plugin 'terryma/vim-multiple-cursors'
" Airline
Plugin 'bling/vim-airline'
" Surround
Plugin 'tpope/vim-surround'
" code control of git, mercurial, darcs, bazaar, subversion, cvs, rcs, fossil, accurev, perforce
Plugin 'mhinz/vim-signify'
Plugin 'aperezdc/vim-template'
Plugin 'maple-leaf/my-vim-templates'

Plugin 'tpope/vim-markdown'

if (has('gui_running'))
    " Adjust font-size
    Plugin 'drmikehenry/vim-fontsize'
endif
