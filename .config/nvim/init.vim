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
  Plug 'yuttie/comfortable-motion.vim'
  Plug 'preservim/nerdcommenter'
  Plug 'matze/vim-move' " Move lines/blocks with alt-h,j,k,l
  Plug 'lambdalisue/fern.vim'
  Plug 'lambdalisue/nerdfont.vim'
  Plug 'lambdalisue/fern-renderer-nerdfont.vim'
  Plug 'arcticicestudio/nord-vim'
call plug#end()

filetype plugin on
autocmd BufNewFile,BufRead *.m set filetype=matlab
syntax on

colorscheme nord

set mouse=a
set clipboard+=unnamedplus
set number relativenumber
set whichwrap+=<,>,h,l,[,]
set splitbelow splitright

let g:matlab_automappings=1
let mapleader = " "
let g:mapleader = " "

map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

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

" Deletes to black hole registry
  nnoremap x "_x
  nnoremap X "_X
  nnoremap d "_d
  nnoremap D "_D
  nnoremap C "_C
  vnoremap d "_d
  vnoremap c "_c
  vnoremap C "_C

" Leader deletes to clipboard
  nnoremap <leader>d "+d
  nnoremap <leader>D "+D
  nnoremap <leader>C "+C
  vnoremap <leader>d "+d
  vnoremap <leader>C "+C
" Fern
  let g:fern#drawer_width = 30
  let g:fern#default_hidden = 1
  let g:fern#disable_drawer_auto_quit = 1

  noremap <silent><leader>f :Fern . -drawer -toggle <CR>

  function! s:init_fern() abort
    nmap <buffer> H <Plug>(fern-action-open:split)
    nmap <buffer> V <Plug>(fern-action-open:vsplit)
    nmap <buffer> R <Plug>(fern-action-rename)
    nmap <buffer> M <Plug>(fern-action-move)
    nmap <buffer> C <Plug>(fern-action-copy)
    nmap <buffer> N <Plug>(fern-action-new-path)
    nmap <buffer> T <Plug>(fern-action-new-file)
    nmap <buffer> D <Plug>(fern-action-new-dir)
    nmap <buffer> S <Plug>(fern-action-hidden-toggle)
    nmap <buffer> dd <Plug>(fern-action-trash)
    nmap <buffer> <leader> <Plug>(fern-action-mark)
  endfunction

  augroup fern-custom
    autocmd! *
    autocmd FileType fern call s:init_fern()
  augroup END

  let g:fern#renderer = "nerdfont"
