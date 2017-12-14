#!/bin/bash
# Store current dir
DIR=$(pwd)

# make a symlink to home directory for given dotfile
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

dotlink vim
dotlink vimrc
curl -fLo vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
