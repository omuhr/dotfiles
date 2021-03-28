#!/bin/bash
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ~
sudo paru -S --needed - < ~/dotfiles/pkg-list.txt
