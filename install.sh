#!/bin/sh
HERE=$(realpath .);
ln -s $HERE/vimrc ~/.vimrc 
ln -s $HERE/vim ~/.vim
git submodule init
git submodule update
