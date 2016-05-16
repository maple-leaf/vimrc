source  /Users/fengye/vimrc/helper.vim

set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('/Users/fengye/vimrc/plugged')

" add or remove your bundles here:
source /Users/fengye/vimrc/plugins.vim

" Add plugins to &runtimepath
call plug#end()
filetype plugin indent on    " required

let mapleader = "\<Space>"

source /Users/fengye/vimrc/plugins-config.vim
source  /Users/fengye/vimrc/settings.vim
source  /Users/fengye/vimrc/keys.vim
