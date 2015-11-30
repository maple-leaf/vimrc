NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

function! FrontEndSupport()
    NeoBundle 'pangloss/vim-javascript'
    NeoBundle 'heavenshell/vim-jsdoc'
    " write html ease
    NeoBundle 'mattn/emmet-vim'
    NeoBundle 'othree/html5.vim'
    " less syntax
    NeoBundle 'groenewege/vim-less'
    " scss syntax
    NeoBundle 'cakebaker/scss-syntax.vim'
    " react jsx support
    NeoBundle 'mxw/vim-jsx.git'
endfunction
call FrontEndSupport()

NeoBundle 'scrooloose/nerdtree'
" vim sessions
NeoBundle 'xolox/vim-misc'
NeoBundle 'xolox/vim-session'
NeoBundle 'danro/rename.vim'
NeoBundle 'godlygeek/tabular'
" Search results counter
NeoBundle 'IndexedSearch'
" Produce increasing/decreasing columns of numbers, dates, or daynames
NeoBundle 'VisIncr'
" Adjust font-size
NeoBundle 'drmikehenry/vim-fontsize'
" grep tool
NeoBundle 'rking/ag.vim'
" bringing Sublime Text's awesome multiple selection feature into Vim
NeoBundle 'terryma/vim-multiple-cursors'
" Airline
NeoBundle 'bling/vim-airline'
" Surround
NeoBundle 'tpope/vim-surround'
" code control of git, mercurial, darcs, bazaar, subversion, cvs, rcs, fossil, accurev, perforce
NeoBundle 'mhinz/vim-signify'
NeoBundle 'aperezdc/vim-template'
NeoBundle 'maple-leaf/my-vim-templates'

NeoBundle 'tpope/vim-markdown'


""""""""""""""""""""
" plugins settings "
""""""""""""""""""""

function! CtrlpConfig()
    let g:ctrlp_working_path_mode = 'rw'
    " use PageUp and PageDown more often than \<C-f\> and \<C-B\>
    nnoremap <silent> <C-b> :CtrlPBuffer<CR>
    nnoremap <silent> <C-m> :CtrlPMRU<CR>
    let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:50'
    let g:ctrlp_use_caching = 1
    let g:ctrlp_clear_cache_on_exit = 0
    let g:ctrlp_show_hidden = 0
    let g:ctrlp_custom_ignore = {
                \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.sass-cache$',
                \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$\|\.scssc$' }
    let g:ctrlp_mruf_relative = 1   " only MRU files in the current working directory

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
endfunction

call CtrlpConfig()

" Session
call EnsureDirExists($HOME . '/.vim/sessions/')
set sessionoptions-=help
let g:session_directory = '~/.vim/sessions/'
let g:session_autosave = 'yes'
let g:session_autoload = 'no'
let g:session_default_name = "last"
no ms :SaveSession 
no \s :OpenSession 

function! NeoCompleteConfig()
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

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

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
        " For no inserting <CR> key.
        "return pumvisible() ? "\<C-y>" : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    " Close popup by <Space>.
    "inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

    " AutoComplPop like behavior.
    "let g:neocomplete#enable_auto_select = 1

    " Shell like behavior(not recommended).
    "set completeopt+=longest
    "let g:neocomplete#enable_auto_select = 1
    "let g:neocomplete#disable_auto_complete = 1
    "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
    "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
endfunction
call NeoCompleteConfig()

" Airline
let g:airline_theme='powerlineish'
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
let g:airline_symbols.branch=''
let g:airline#extensions#default#section_truncate_width = {
\ 'a': 80,
\ 'x': 80,
\ 'y': 80,
\ 'z': 80,
\ }
