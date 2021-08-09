" #####################################################
" ###                   Vim Config                  ###
" #####################################################

syntax enable                           " enable syntax hightlightning
set hlsearch                            " Hightlight search results
set t_Co=256                            " Enable 256 Color Palette

set number                              " show line numbers

set autoindent                          " Auto-indent new lines
set smartindent                         " enables smart-indentation

set tabstop=4							" Make tabs stop in 4 spaces

set encoding=utf8                       " Default Encoding to UTF-8

if !has('gui_running')					" Lightline Color
	set t_Co=256
endif

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
	Plugin 'davidhalter/jedi-vim'		" Jedi Python
	Plugin 'ryanoasis/vim-devicons'		" Icons for Vim
	Plugin 'preservim/nerdtree'			" NerdTree

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

" #####################################################
" ###					Jedi-Vim					###
" #####################################################
autocmd FileType python setlocal completeopt-=preview	" Disable DocString Window Preview

" #####################################################
" ###					NerdTree					###
" #####################################################
let NERDTreeShowLineNumbers = 1
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1
let g:NERDTreeWinSize = 38

map <C-n> :NERDTreeToggle<CR>
