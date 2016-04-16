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
call ctrlp_bdelete#init()

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
"call NeoCompleteConfig()

function! YouCompleteMe()
    let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ 'unite' : 1,
      \ 'text' : 1,
      \ 'vimwiki' : 1,
      \ 'gitcommit' : 1,
      \}

    autocmd FileType javascript setlocal omnifunc=tern#Complete
endfunction

function! NeoSnippetConfig()
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)
endfunction
"call NeoSnippetConfig()

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

function! UniteConfig()
    " c-l refresh results
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    call unite#custom#source(
                \ 'neomru/file', 'matchers',
                \ ['matcher_project_files', 'matcher_fuzzy'])
    " this is to slow
    "nnoremap <c-p> :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
    "nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
    "nnoremap <c-m> :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
    nnoremap <c-o> :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
    "nnoremap <c-h> :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
    "nnoremap <c-b> :<C-u>Unite -no-split -buffer-name=buffer -start-insert buffer<cr>
    nnoremap <leader>/ :<C-u>Unite -no-split -start-insert -buffer-name=lineSearch  line<cr>

    nnoremap <c-f> :<C-u>Unite -no-split -start-insert -buffer-name=projectSearch grep -no-empty<cr>
    " Using ag as recursive command.
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts =
                \ '-i --vimgrep --hidden --ignore ' .
                \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    let g:unite_source_grep_recursive_opt = ''

    " when press escape, exit unite.
    " this will cause arrow keys not working correctly which cause
    " unit exit and insert charactor in your current file
    " https://github.com/Shougo/unite.vim/issues/693
    au FileType unite imap <buffer><silent> <ESC> <Plug>(unite_exit)
endfunction
"call UniteConfig()

function! UltiSnipsConfig()
    let g:UltiSnipsExpandTrigger = '<c-k>'
    let g:UltiSnipsJumpForwardTrigger = '<c-k>'
    let g:UltiSnipsJumpBackwardTrigger = '<c-i>'
    let g:UltiSnipsEditSplit = 'horizontal'
    if !isdirectory('~/.vim/bundle/UltiSnips-ext')
        let g:UltiSnipsSnippetsDir = '~/.vim/bundle/UltiSnips-ext/UltiSnips/'
    endif
endfunction
call UltiSnipsConfig()

" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

if (has('gui_running'))
    function! FontsizeConfig()
        nmap <silent> <c-=>  <Plug>FontsizeBegin
        nmap <silent> <c-+>  <Plug>FontsizeInc
        nmap <silent> <Leader>-  <Plug>FontsizeDec
        nmap <silent> <Leader>0  <Plug>FontsizeDefault
    endfunction
    call FontsizeConfig()
endif
