" NVim General Settings

" Use alt + hjkl to resize windows
nnoremap <M-j> :resize -2<CR>
nnoremap <M-k> :resize +2<CR>
nnoremap <M-h> :vertical resize -2<CR>
nnoremap <M-l> :vertical resize +2<CR>

" TAB to cycly through buffers
nnoremap <TAB> :bnext<CR>
" Shift + Tab go back
nnoremap <S-TAB> :bprevious<CR>

" Alternate ways to
" Save
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>
" Quit
nnoremap <C-q> :q!<CR>
inoremap <C-q> <ESC>:q!<CR>
" Save and Quit
nnoremap <C-Q> :wq!<CR>
"<TAB>: completion
inoremap <expr><TAB> pumvisible()? "\<C-n>":"\<TAB>"

" Better Tabbing
vnoremap < <gv
vnoremap > >gv

" Better Window Nav
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <Leader>o o<Esc>^Da
nnoremap <Leader>O O<Esc>^Da
