function! NeomakeConfig()
    " eslint --init First!! in your project
    autocmd! BufWritePost * Neomake
    let g:neomake_open_list = 0
    let g:neomake_list_height = 5
    let g:neomake_place_signs = 1
    nmap <Leader><Space>n :lnext<CR>      " next error/warning
    nmap <Leader><Space>p :lprev<CR>      " previous error/warning

    "let g:neomake_javascript_jshint_maker = {
                "\ 'args': ['--verbose', '--config=$XDG_DATA_HOME/nvim/.jshintrc'],
                "\ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
                "\ }
    let g:neomake_javascript_enabled_makers = ['eslint']

    function! NeomakeESlintChecker()
        "  configure b:syntastic_javascript_eslint_exec to point to the
        "  locally installed version of eslint if it exists otherwise fallback to the globally installed
        "  https://github.com/benekastah/neomake/issues/247#issuecomment-175808155
        " https://github.com/airbnb/javascript/issues/465#issuecomment-173281502
        let l:npm_bin = ''
        "let l:eslint = 'eslint'
        let l:eslint = 'eslint_d' " https://github.com/mantoni/eslint_d.js make eslint faster

        if executable('npm')
            let l:npm_bin = split(system('npm bin'), '\n')[0]
        endif

        if strlen(l:npm_bin) && executable(l:npm_bin . '/eslint_d')
            let l:eslint = l:npm_bin . '/eslint_d'
        endif

        let b:neomake_javascript_eslint_exe = l:eslint
    endfunction

    autocmd FileType javascript :call NeomakeESlintChecker()
    autocmd! BufWritePost,BufReadPost * Neomake
endfunction
call NeomakeConfig()

function! ImportJsConfig()
    " Import the module for the variable under the cursor.
    no <Leader>im   :ImportJSImport<cr>
    " Import any missing modules and remove any modules that are not used.
    no <Leader>ia   :ImportJSFixImports<cr>
    " Go to the module of the variable under the cursor.
    no <Leader>gi   :ImportJSGoTo<cr>
endfunction
call ImportJsConfig()

function! TernJsConfig()
    " Jump to the definition of the thing under the cursor.
    no <Leader>tf :TernDef<cr>
    " Look up the documentation of something.
    no <Leader>td :TernDoc<cr>
    " Find the type of the thing under the cursor.
    no <Leader>tt :TernType<cr>
    " Show all references to the variable or property under the cursor.
    no <Leader>tr :TernRefs<cr>
    " Rename the variable under the cursor.
    no <Leader>tn :TernRename<cr>
endfunction
call TernJsConfig()

function! CtrlpConfig()
    let g:ctrlp_working_path_mode = 'rw'
    "nnoremap <silent> <C-b> :CtrlPBuffer<CR>
    function! MapCr()
        if &buftype ==# "quickfix"
            execute "normal! \<CR>"
        else
            ":CtrlPMRUFiles<cr>
            :CtrlPBuffer
        endif
    endfunction
    nnoremap <silent> <C-m> :call MapCr()<cr>
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

" Unite
function! UniteConfig()
    " Set up some custom ignores
    call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
                \ 'ignore_pattern', join([
                \ '\.git/',
                \ 'node_modules/',
                \ ], '\|'))

    "if executable('ag')
        "let g:unite_source_rec_async_command= 'ag --follow --nocolor --nogroup --hidden -g ""'
        "let g:unite_source_grep_command = 'ag'
        "let g:unite_source_grep_default_opts = '--column --nogroup --nogroup'
        "let g:unite_source_grep_recursive_opt = ''
    "endif

    let g:unite_source_rec_max_cache_files = 99999

    let g:unite_source_history_yank_enable = 1
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    nnoremap <C-p> :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
    nnoremap <C-i> :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
    "nnoremap <C-m> :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru:!<cr>
    nnoremap <C-o> :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
    nnoremap <C-h> :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
    nnoremap <C-m> :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>
endfunction
"call UniteConfig()

" Session
function! SessionConfig()
    call EnsureDirExists($HOME . '/.vim/sessions/')
    set sessionoptions-=help
    let g:session_directory = $HOME . '/.vim/sessions/'
    let g:session_autosave = 'yes'
    let g:session_autoload = 'no'
    let g:session_default_name = "last"
    no ms :SaveSession 
    no \s :OpenSession 
endfunction
call SessionConfig()

function! UltiSnipsConfig()
    let g:UltiSnipsExpandTrigger = '<c-k>'
    let g:UltiSnipsJumpForwardTrigger = '<c-k>'
    let g:UltiSnipsJumpBackwardTrigger = '<c-i>'
    let g:UltiSnipsEditSplit = 'horizontal'
    if isdirectory($HOME . '/vimrc/plugged/UltiSnips-ext')
        let g:UltiSnipsSnippetsDir = $HOME . '/.vim/plugged/UltiSnips-ext/UltiSnips/'
    endif
endfunction
call UltiSnipsConfig()

" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

function! AirlineConfig()
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
    let g:airline#extensions#branch#enabled = 1
endfunction
call AirlineConfig()

function! FugittiveConfig()
  nmap <Leader>gs <Plug>GitGutterStageHunk
  nmap <Leader>gr <Plug>GitGutterRevertHunk
  nmap <Leader>gp <Plug>GitGutterPreviewHunk
endfunction
call FugittiveConfig()

" vim-over
function! VimOverConfig()
    nmap <Leader>ss :OverCommandLine<cr>
endfunction
call VimOverConfig()
