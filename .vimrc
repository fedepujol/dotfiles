" #####################################################
" ###                   Vim Config                  ###
" #####################################################

syntax enable                           " enable syntax hightlightning
set showmatch                           " Hightlight matching brace
set hlsearch                            " Hightlight search results
set t_Co=256                            " Enable 256 Color Palette

set number                              " show line numbers

set autoindent                          " Auto-indent new lines
set smartindent                         " enables smart-indentation
set smarttab                            " smart use of tabs
set shiftwidth=4                        " 1 tab == 4 spaces
set tabstop=4                           " 1 tab == 4 spaces

set mouse=nicr                          " mouse scrolling

set encoding=utf8                       " Default Encoding to UTF-8

set nobackup                            " 
set noswapfile                          " 

" #####################################################
" ###                   ColorScheme                 ###
" #####################################################

hi Comment      ctermfg=22 ctermbg=none cterm=bold   " Not Working
hi LineNr       ctermfg=8
hi CursorLineNr	ctermfg=7

" #####################################################
" ###               Vundle PlugManager              ###
" #####################################################

set nocompatible                        " be iMproved, required
filetype off                            " required

set rtp+=~/.vim/bundle/Vundle.vim       " set runtime path include Vundle

call vundle#begin()                     " required, all plugins after this line.

    Plugin 'gmarik/Vundle.vim'          " Vundle
    Plugin 'itchyny/lightline.vim'      " Lightline StatusBar
    Plugin 'ap/vim-css-color'           " Color Preview

call vundle#end()                       " required, all plugins must go before this line.

filetype plugin indent on               " required

" #####################################################
" ###                   StatusBar                   ###
" #####################################################
let g:lightline = {
	\ 'colorscheme': 'PaperColor_dark',
	\ }

set laststatus=2                        " Always shows statusbar
set noshowmode                          " Uncomment to prevent non-normal modes showing in the statusbar

