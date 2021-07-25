" Usefull Keys-(Re)mappings

syntax enable				" Enable syntax
set hidden				    " Required to keep multiple buffers open
set nowrap				    " Display long lines as such
set encoding=UTF-8			" Force encoding to UTF-8
set pumheight=10			" Pop-Up menu smaller
set fileencoding=UTF-8		" Force file encoding to UTF-8
set ruler				    " Show the cursor all the time
set cmdheight=2				" More space to display messages
set iskeyword+=-			" Treat dash separated words as a word text object
set mouse=a				    " Enable mouse
set splitbelow				" Horizontal splits will automatically be bellow
set splitright				" Vertical splits will automatically be on the right
set t_Co=256				" Support 256 colors
set conceallevel=0			" See `` in markdown files
set tabstop=4				" Set 1 tab to 4 spaces
set shiftwidth=4			" Change number of spaces inserted for indentation
set smarttab				" Makes tabbing smarter (will realize 4 spaces)
set expandtab				" Converts tabs into spaces
set autoindent				" Auto indent
set smartindent				" Makes indenting smarter
set number				    " Line numbers
set cursorline				" Enable hightlightning of the current line
set background=dark			" Tell NeoVim what the background color looks like
set showtabline=4			" Always show tabs
set noshowmode				" Lightline
set nobackup				" Recommended by COC
set nowritebackup			" Recommended by COC
set updatetime=300			" Faster completion
set timeoutlen=500			" Timeoutlen is 1000ms by default
set formatoptions-=cro		" Stop newline continuation of comments
set clipboard=unnamedplus	" Copy Paste between NeoVim and everything else

au! BufWritePost $MYVIMRC source %	" Auto source when writing to init.vim
