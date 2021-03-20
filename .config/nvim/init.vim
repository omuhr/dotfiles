if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/autload/plugged')	
	Plug 'jiangmiao/auto-pairs'
	Plug 'sheerun/vim-polyglot'
call plug#end()

set clipboard+=unnamedplus
set number relativenumber
