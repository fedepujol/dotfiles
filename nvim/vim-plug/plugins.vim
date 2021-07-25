" Vim-Plug settings

call plug#begin("~/.config/nvim/autoload/plugged")

    Plug 'itchyny/lightline.vim'                                        " Lightline
    Plug 'ryanoasis/vim-devicons'                                       " Dev-Icons
    Plug 'ap/vim-css-color'                                             " HexColor Preview
    Plug 'kovetskiy/sxhkd-vim'                                          " SXHKD Highlighning
    Plug 'arcticicestudio/nord-vim'                                     " Nord Theme
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}         " Treesitter
    Plug 'kevinhwang91/rnvimr'                                          " Ranger
    Plug 'neovim/nvim-lspconfig'                                        " LSP
    Plug 'hrsh7th/nvim-compe'                                           " AutoComplete
    Plug 'hrsh7th/vim-vsnip'
    Plug 'rafamadriz/friendly-snippets'

call plug#end()

