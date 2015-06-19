execute pathogen#infect()

syntax on
filetype plugin indent on

set background=dark
set laststatus=2
colorscheme solarized

set nu
set ts=4
set sw=4
set expandtab

map <C-p> :CtrlP
map <C-j> <C-w><C-]><C-w>T

nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

nmap gh <C-w>h
nmap gj <C-w>j
nmap gk <C-w>k
nmap gl <C-w>l

nmap <C-l> gt
nmap <C-h> gT
