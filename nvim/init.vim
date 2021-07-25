source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/mapping.vim
source $HOME/.config/nvim/vim-plug/plugins.vim
" source $HOME/.config/nvim/themes/nord.vim

luafile $HOME/.config/nvim/vim-plug/settings/nvimr.lua
luafile $HOME/.config/nvim/vim-plug/settings/treesitter.lua
luafile $HOME/.config/nvim/vim-plug/settings/compe.lua
luafile $HOME/.config/nvim/vim-plug/settings/lsp.lua

luafile $HOME/.config/nvim/lsp/python.lua
luafile $HOME/.config/nvim/lsp/bash.lua
luafile $HOME/.config/nvim/lsp/vim.lua
