if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
call plug#begin('~/.config/nvim/autoload/plugged')	
	Plug 'sheerun/vim-polyglot'
  Plug 'yggdroot/indentline'
  Plug 'kien/rainbow_parentheses.vim'
  Plug 'daeyun/vim-matlab', { 'do': function('DoRemote') }
call plug#end()

filetype plugin on
autocmd BufNewFile,BufRead *.m set filetype=matlab
syntax on

set mouse=a
set clipboard+=unnamedplus
set number relativenumber
set whichwrap+=<,>,h,l,[,]
set splitbelow splitright

let g:matlab_automappings=1

" Fuck habits
nmap <Up>    <Nop>
nmap <Down>  <Nop>
nmap <Left>  <Nop>
nmap <Right> <Nop>

" Nicer split movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Capitalized movement for longer distance
map ^ <Nop>
map { <Nop>
map } <Nop>
noremap K     {
noremap J     }
noremap H     ^
noremap L     $

" VI-movement in insert mode
imap <Up>    <Nop>
imap <Down>  <Nop>
imap <Left>  <Nop>
imap <Right> <Nop>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" Tab to tab in normal and visual modes
nmap >> <Nop>
nmap << <Nop>
vmap >> <Nop>
vmap << <Nop>
nnoremap <Tab>   >>
nnoremap <S-Tab> <<
vnoremap <Tab>   >><Esc>gv
vnoremap <S-Tab> <<<Esc>gv

" Y yanks from cursor to end of line
nnoremap Y y$
