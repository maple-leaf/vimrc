Plug 'flazz/vim-colorschemes'
Plug 'junegunn/vim-easy-align'

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' | Plug 'maple-leaf/UltiSnips-ext'
Plug 'benekastah/neomake'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'd11wtq/ctrlp_bdelete.vim'
"Plug 'Shougo/unite.vim'
"Plug 'Shougo/neomru.vim'
"Plug 'Shougo/vimproc.vim', {'do': 'make'}

" vim sessions
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'danro/rename.vim'
" Search results counter
Plug 'IndexedSearch'
" Produce increasing/decreasing columns of numbers, dates, or daynames
Plug 'VisIncr'
" grep tool
Plug 'rking/ag.vim'
Plug 'tpope/vim-surround'
Plug 'aperezdc/vim-template'
Plug 'maple-leaf/my-vim-templates'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'osyo-manga/vim-over' " search/replace with preview
Plug 'Valloric/YouCompleteMe', {'do': './install.py --tern-completer'}

function! FrontEndSupport()
    Plug 'heavenshell/vim-jsdoc'
    " write html ease
    Plug 'mattn/emmet-vim'
    Plug 'othree/html5.vim'
    " less syntax
    Plug 'groenewege/vim-less'
    " scss syntax
    Plug 'cakebaker/scss-syntax.vim'
    " react jsx support
    Plug 'mxw/vim-jsx'
    " XML/HTML tags navigation
    Plug 'matchit.zip'

    " JS syntax, supports ES6
    Plug 'othree/yajs.vim', {
                \   'for': ['javascript']
                \ }
    " Better indentation
    Plug 'gavocanov/vim-js-indent', {
                \   'for': ['javascript']
                \ }
    " JS syntax for common libraries
    Plug 'othree/javascript-libraries-syntax.vim', {
                \   'for': ['javascript']
                \ }
    " Tern auto-completion engine for JS (requires node/npm)
    if executable('node')
        Plug 'marijnh/tern_for_vim', {
                    \     'do': 'npm install',
                    \     'for': ['javascript', 'coffee']
                    \   }
    endif
    " automatically import dependencies in your JavaScript project
    " or jump to deps file
    Plug 'trotzig/import-js', {
                \ 'for': ['javascript']
                \}
    Plug 'ludovicchabant/vim-gutentags'
endfunction
call FrontEndSupport()
