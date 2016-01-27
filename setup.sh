#!/bin/sh
ln -s $PWD/xinitrc $HOME/.xinitrc 
ln -s $PWD/bash_profile $HOME/.bash_profile 
ln -s $PWD/bashrc $HOME/.bashrc
ln -sn $PWD/xmonad $HOME/.xmonad
ln -s $PWD/Xresources $HOME/.Xresources
ln -s $PWD/xmobarrc $HOME/.xmobarrc
ln -s $PWD/vimrc $HOME/.vimrc

if [ `uname -o` = "Cygwin" ]; then 
    curl -LSso $HOME/.minttyrc https://raw.githubusercontent.com/mavnn/mintty-colors-solarized/master/.minttyrc.dark
fi

mkdir -p $HOME/.vim/autoload/
curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
mkdir -p $HOME/.vim/bundle/
cd $HOME/.vim/bundle/
git clone https://github.com/altercation/vim-colors-solarized.git
git clone https://github.com/ctrlpvim/ctrlp.vim.git
