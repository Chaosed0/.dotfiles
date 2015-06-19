#!/bin/sh
# Install vim packages
mkdir -p $HOME/.vim/bundle
mkdir -p $HOME/.vim/autoload $HOME/.vim/bundle
curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git clone https://github.com/kien/ctrlp.vim.git $HOME/.vim/bundle/ctrlp.vim
git clone https://github.com/bling/vim-airline.git $HOME/.vim/bundle/vim-airline
git clone https://github.com/altercation/vim-colors-solarized.git $HOME/.vim/bundle/vim-colors-solarized
