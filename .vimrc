
" Vundle & YouCompleteMe
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
call vundle#end()
filetype plugin indent on

let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py"

set cindent
set number
set showcmd
set ruler
set hlsearch
set incsearch
set mouse=a
set shiftwidth=4
set tabstop=4
set softtabstop=4
nnoremap <silent> <F10> :TlistToggle<CR>
let Tlist_Exit_OnlyWindow = 1
let Tlist_Auto_Open = 1
colorscheme desert256
