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
  Plug 'kien/rainbow_parentheses.vim'
  Plug 'daeyun/vim-matlab', { 'do': function('DoRemote') }
  Plug 'yuttie/comfortable-motion.vim'
  Plug 'preservim/nerdcommenter'
  Plug 'matze/vim-move' " Move lines/blocks with alt-h,j,k,l
  Plug 'lambdalisue/fern.vim'
  Plug 'lambdalisue/nerdfont.vim'
  Plug 'lambdalisue/fern-renderer-nerdfont.vim'
  Plug 'lambdalisue/fern-hijack.vim'
  Plug 'arcticicestudio/nord-vim'
  Plug 'joshdick/onedark.vim'
  Plug 'lervag/vimtex'
  Plug 'dahu/vim-fanfingtastic'
call plug#end()

filetype plugin indent on
autocmd BufNewFile,BufRead *.m set filetype=matlab
syntax on

let g:onedark_terminal_italics=1
colorscheme onedark

" sets
  set termguicolors
  set mouse=a
  set clipboard+=unnamedplus
  set number relativenumber
  set splitbelow splitright
  set textwidth=80
  set hidden
  set encoding=utf-8
  set nowrap
  set smarttab
  set smartindent
  set autoindent
  set background=dark
  set colorcolumn=80
  set cocu=""

"set whichwrap+=<,>,h,l,[,]

" lets
  let g:matlab_automappings=1
  let mapleader = " "
  let g:mapleader = " "

" vimtex
  let g:tex_flavour='latex'
  let g:vimtex_view_method='zathura'
  let g:vimtex_quickfix_mode=0
  set conceallevel=2
  let g:vimtex_syntax_conceal={'math_super_sub':'1', 'math_fracs':'1'}
  "let g:vimtex_syntax_conceal_cites={'type':'icon'}
  " mouse
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
  let g:fern#drawer_width = 40
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

" Removes trailing spaces
  function TrimWhiteSpace()
    %s/\s*$//
    ''
  endfunction

  set list listchars=trail:.,extends:>
  autocmd FileWritePre * call TrimWhiteSpace()
  autocmd FileAppendPre * call TrimWhiteSpace()
  autocmd FilterWritePre * call TrimWhiteSpace()
  autocmd BufWritePre * call TrimWhiteSpace()
