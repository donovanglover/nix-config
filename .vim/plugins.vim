" New Start: A modern Arch workflow built with an emphasis on functionality.
" Copyright (C) 2017-2018 Donovan Glover

call plug#begin('~/.vim/plugged')       " Use vim-plug as our package manager of choice
    Plug 'airblade/vim-gitgutter'       " Add git diff support
    Plug 'dylanaraps/wal.vim'           " Add wal support
    Plug 'osyo-manga/vim-over'          " Automatically highlight find and replace
    Plug 'jiangmiao/auto-pairs'         " Close brackets and other pairs automatically
    Plug 'w0rp/ale'                     " Automatically check language syntax for errors
    Plug 'maksimr/vim-jsbeautify'       " Make it easier to work with foreign code
    Plug 'lervag/vimtex'                " Make editing LaTeX a breeze
    Plug 'dbeniamine/todo.txt-vim'      " Easily manage any part of your todo.txt
    Plug 'elixir-editors/vim-elixir'    " Add syntax highlighting and autoindent for Elixir

    Plug 'tpope/vim-fugitive'           " Add fugitive.vim, enabling us to use git in vim
    Plug 'junegunn/fzf'                 " Add fuzzy finding to easily move between files
    Plug 'junegunn/fzf.vim'             " Add the vim functionality of fuzzy finding

    Plug 'rhysd/vim-crystal'            " Add support for the crystal language
    Plug 'scrooloose/nerdtree'          " Add a file browser to vim

    Plug 'rust-lang/rust.vim'           " Add rust support to vim

    Plug 'jamessan/vim-gnupg'           " Easily use GPG encryption inside of vim
    Plug 'reedes/vim-pencil'            " Use vim as a tool for writing
    Plug 'mileszs/ack.vim'              " Testing ack.vim with ag
    Plug 'tpope/vim-endwise'            " Automatically add end
    Plug 'junegunn/goyo.vim'            " Distraction-free writing
    Plug 'Yggdroot/indentLine'          " Show indentation levels

    Plug 'Shougo/unite.vim'             " Required by vimfiler
    Plug 'Shougo/vimfiler.vim'          " Yet another file explorer

    Plug 'mattn/emmet-vim'              " Add emmet support
    Plug 'sgur/vim-editorconfig'        " Add editorconfig support
    Plug 'baskerville/vim-sxhkdrc'      " Add sxhkdrc support
    Plug 'cespare/vim-toml'             " Add toml support
    Plug 'dag/vim-fish'                 " Add fish support
    Plug 'slim-template/vim-slim'       " Add slim support
    Plug 'pangloss/vim-javascript'      " Improve JavaScript support
    Plug 'othree/html5.vim'             " Improve HTML support
    Plug 'alvan/vim-closetag'           " Automatically close tags when writing HTML
    Plug 'tpope/vim-surround'           " Easily add or remove surrounding characters
    Plug 'chrisbra/csv.vim'             " Add CSV support
    Plug 'Glench/Vim-Jinja2-Syntax'     " Add Jinja2 support
    Plug 'mustache/vim-mustache-handlebars' " Add mustache and handlebars support
    Plug 'plasticboy/vim-markdown'          " Add more markdown support (LaTeX, frontmatter, etc.)
    Plug 'quabug/vim-gdscript'          " Add Godot support
    Plug 'posva/vim-vue'                " Add Vue support
    Plug 'mxw/vim-jsx'                  " Add React support
    Plug 'digitaltoad/vim-pug'          " Add Pug support
    Plug 'kchmck/vim-coffee-script'     " Add CoffeeScript support
    Plug 'leafgarland/typescript-vim'   " Add TypeScript support
call plug#end()                         " Start the plugins
