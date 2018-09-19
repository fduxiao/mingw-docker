#!/bin/sh
sudo -u pkg git clone https://aur.archlinux.org/$1.git
cd $1 && sudo -u pkg makepkg
pacman -U --noconfirm $1-*.tar.xz
cd .. && rm -rf $1

