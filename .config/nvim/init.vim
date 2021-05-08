" Install vim-plug if it isn't already
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin('~/.config/nvim/autoload/plugged')
  " Add syntax and indentation support for a ton of languages
  Plug 'sheerun/vim-polyglot'
  " Add ranbow coloring to nested delimiters
  Plug 'luochen1990/rainbow'
  " Auto close delimiters
  Plug 'cohama/lexima.vim'
  " Improves interaction with delimiter
  Plug 'tpope/vim-surround'
  " Extends repeatability with . function
  Plug 'tpope/vim-repeat'
  " Enables matlab interaction
  Plug 'daeyun/vim-matlab', { 'do': function('DoRemote') }
  " Smooth scrolling
  Plug 'yuttie/comfortable-motion.vim'
  " Comment engine
  Plug 'preservim/nerdcommenter'
  " Move lines/blocks with alt-h,j,k,l
  Plug 'matze/vim-move'
  " File manager
  Plug 'lambdalisue/fern.vim'
  " Nerdfont icons for fern
  Plug 'lambdalisue/nerdfont.vim'
  Plug 'lambdalisue/fern-renderer-nerdfont.vim'
  " Allows fern to launch when neovim is run on a directory
  Plug 'lambdalisue/fern-hijack.vim'
  " Nord theme
  Plug 'arcticicestudio/nord-vim'
  " One Dark theme
  Plug 'joshdick/onedark.vim'
  Plug 'lervag/vimtex'
  " Allow f, F, t, and T to search accros line breaks
  Plug 'dahu/vim-fanfingtastic'
  " Autocomplete engine
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " Snippet engine
  Plug 'SirVer/ultisnips'
  " Snippets are separated from the engine. Add this if you want them:
  Plug 'honza/vim-snippets'
  " Improved environment matching
  Plug 'andymass/vim-matchup'
call plug#end()

filetype plugin indent on
autocmd BufNewFile,BufRead *.m set filetype=matlab
syntax on

colorscheme onedark
let g:onedark_terminal_italics=1


" Sets
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

" Lets
  let g:rainbow_active = 1
  let g:deoplete#enable_at_startup = 1
  let g:matlab_automappings=1
  let mapleader = " "
  let g:mapleader = " "

" Enable mouse scrolling
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

" Capitalized movement for long distance
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
  nnoremap <leader>x "+x
  nnoremap <leader>X "+X
  nnoremap <leader>d "+d
  nnoremap <leader>D "+D
  nnoremap <leader>c "+c
  nnoremap <leader>C "+C

  vnoremap <leader>x "+x
  vnoremap <leader>X "+X
  vnoremap <leader>d "+d
  vnoremap <leader>D "+D
  vnoremap <leader>c "+c
  vnoremap <leader>C "+C

" Vimtex
  let g:tex_flavour='latex'
  let g:vimtex_view_method='zathura'
  let g:vimtex_quickfix_mode=0
  set conceallevel=2
  let g:vimtex_syntax_conceal={'math_super_sub':'1', 'math_fracs':'1'}
  "let g:vimtex_syntax_conceal_cites={'type':'icon'}

" Matchup
  " Override vimtex matchit rules
  let g:matchup_override_vimtex = 1

" Lexima
  " Add support for $$ in latex
  call lexima#add_rule({'char': '$', 'input_after': '$', 'filetype': 'latex'})
  call lexima#add_rule({'char': '$', 'at': '\%#\$', 'leave': 1, 'filetype': 'latex'})
  call lexima#add_rule({'char': '<BS>', 'at': '\$\%#\$', 'delete': 1, 'filetype': 'latex'})

" Ultisnips
  " Vimtex specific
  call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})
  " Ultisnips binds
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<a-n>"
  let g:UltiSnipsJumpBackwardTrigger="<a-p>"

  " If you want :UltiSnipsEdit to split your window.
  let g:UltiSnipsEditSplit="vertical"

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

" Removes trailing whitespace
  function TrimWhiteSpace()
    %s/\s*$//
    ''
  endfunction

  set list listchars=trail:.,extends:>
  autocmd FileWritePre * call TrimWhiteSpace()
  autocmd FileAppendPre * call TrimWhiteSpace()
  autocmd FilterWritePre * call TrimWhiteSpace()
  autocmd BufWritePre * call TrimWhiteSpace()
