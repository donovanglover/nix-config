" New Start: A modern Arch workflow built with an emphasis on functionality.
" Copyright (C) 2017-2018 Donovan Glover

set runtimepath^=~/.vim runtimepath+=~/.vim/after

let &packpath = &runtimepath

" Enable global clipboard support for all vim commands in neovim
" NOTE: It may be better to just add a keybind for "+(y), or just
" use that instead.
set clipboard=unnamedplus

source ~/.vimrc
