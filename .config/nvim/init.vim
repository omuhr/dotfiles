if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin('~/.config/nvim/autoload/plugged')	
	Plug 'jiangmiao/auto-pairs'
	Plug 'sheerun/vim-polyglot'
  Plug 'yggdroot/indentline'
  Plug 'kien/rainbow_parentheses.vim'
  Plug 'daeyun/vim-matlab', { 'do': function('DoRemote') }
call plug#end()

set clipboard+=unnamedplus
set number relativenumber
