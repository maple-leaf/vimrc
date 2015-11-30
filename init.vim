source  /Users/fengye/vimrc/helper.vim

"NeoBundle Scripts-----------------------------
set runtimepath+=/Users/fengye/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('/Users/fengye/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
source /Users/fengye/vimrc/plugins.vim

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

source  /Users/fengye/vimrc/settings.vim
source  /Users/fengye/vimrc/keys.vim

