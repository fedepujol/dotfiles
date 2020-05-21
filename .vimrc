" ###################################################
" ###              Vundle PlugManager             ###
" ###################################################

set nocompatible	" be iMproved, required
filetype off		" required

" set runtime path include Vundle
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()	" required, all plugins after this line.

Plugin 'gmarik/Vundle.vim'	" Vundle
Plugin 'itchyny/lightline.vim'	" Lightline StatusBar
Plugin 'ap/vim-css-color'	" Color Preview

call vundle#end()	" required, all plugins must go before this line.

filetype plugin indent on " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""			StatusBar
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
	\ 'colorscheme': 'PaperColor_dark',
	\ }

" Always shows statusbar
set laststatus=2

" Uncomment to prevent non-normal modes showing in the statusbar
set noshowmode

syntax enable
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""		Color Config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi Comment ctermfg=22 ctermbg=none cterm=bold
hi LineNr  ctermfg=8
hi CursorLineNr	ctermfg=7

 
set number
