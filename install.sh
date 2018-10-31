#!/bin/bash

# Store current dir
DIR=$(pwd)

# Make a symlink to HOME directory for given dotfile
function dotlink(){
    local FROM=$HOME/.$1
    local TO=$DIR/$1

    if [ -d "$FROM" ]; 
    then
        echo "Directory $FROM exists, deleting..."
        rm -r $FROM
    fi

    if [ -f "$FROM" ]; 
    then
        echo "File $FROM exists, deleting..."
        rm $FROM
    fi

    echo "Simlink from $FROM to $TO created!"
    ln -sfn $TO $FROM
}

function create_links(){
    dotlink vim
    dotlink vimrc
}


while true; do
    read -p "This script will replace your current VIM configuration. Do you want to continue? [y/n] " yn
    case $yn in
        [Yy]* ) create_links; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

while true; do
    read -p "Do you want to install plug.vim? [y/n] " yn
    case $yn in
        [Yy]* ) curl -fLo vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
