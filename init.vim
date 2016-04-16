source  /Users/fengye/vimrc/helper.vim

" setting for vundle
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required!
Plugin 'VundleVim/Vundle.vim'

" add or remove your bundles here:
source /Users/fengye/vimrc/plugins.vim

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

source /Users/fengye/vimrc/plugins-config.vim
source  /Users/fengye/vimrc/settings.vim
source  /Users/fengye/vimrc/keys.vim

