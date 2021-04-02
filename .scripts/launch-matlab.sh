#!/bin/sh
session_name='Matlab'

tmux has-session -t $session_name
if [ $? != 0 ]
then
    #########################
    # Session/Window 0
    #########################
    cd ~
    tmux new-session               -ds $session_name
    tmux set-window-option          -t $session_name     allow-rename off
    tmux rename-window              -t $session_name:0   www-00

    # Pane 0.0
    tmux send-keys                  -t $session_name:0.0 'nvim /home/muoscar/Documents/MATLAB/' C-m

    # Pane 0.1
    tmux split-window      -h -p 25 -t $session_name:0
    tmux send-keys                  -t $session_name:0.1 '/home/muoscar/.config/nvim/autoload/plugged/vim-matlab/scripts/vim-matlab-server.py' C-m

    tmux select-pane                -t 0
fi

tmux attach -t $session_name
