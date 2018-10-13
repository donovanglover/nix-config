" New Start: A modern Arch workflow built with an emphasis on functionality.
" Copyright (C) 2017-2018 Donovan Glover

call plug#begin('~/.vim/plugged')
    Plug 'dylanaraps/wal.vim'           " Color scheme
    Plug 'airblade/vim-gitgutter'       " Git diff
    Plug 'itchyny/lightline.vim'        " Status line
    Plug 'w0rp/ale'                     " Syntax checker
    Plug 'sgur/vim-editorconfig'        " EditorConfig
    Plug 'tpope/vim-fugitive'           " Git wrapper
    Plug 'junegunn/fzf.vim'             " fzf wrapper
    Plug 'jiangmiao/auto-pairs'         " {Pair} completion
    Plug 'tpope/vim-endwise'            " 'End' completion
    Plug 'reedes/vim-pencil'            " Word wrap
    Plug 'junegunn/goyo.vim'            " Distraction-free writing

    Plug 'osyo-manga/vim-over',         {'on': 'OverCommandLine'}
    Plug 'maksimr/vim-jsbeautify',      {'on': ['JsBeautify', 'JsonBeautify',
        \                       'JsxBeautify', 'HtmlBeautify', 'CSSBeautify']}

    Plug 'pangloss/vim-javascript',     {'for': 'javascript'}
    Plug 'alvan/vim-closetag',          {'for': 'html'}
    Plug 'rhysd/vim-crystal',           {'for': 'crystal'}
    Plug 'rust-lang/rust.vim',          {'for': 'rust'}
    Plug 'baskerville/vim-sxhkdrc',     {'for': 'sxhkdrc'}
    Plug 'cespare/vim-toml',            {'for': 'toml'}
    Plug 'dag/vim-fish',                {'for': 'fish'}
    Plug 'slim-template/vim-slim',      {'for': 'slim'}
    Plug 'Glench/Vim-Jinja2-Syntax',    {'for': 'jinja2'}
    Plug 'plasticboy/vim-markdown',     {'for': 'markdown'}
    Plug 'posva/vim-vue',               {'for': 'vue'}
    Plug 'mxw/vim-jsx',                 {'for': 'javascript'}
    Plug 'digitaltoad/vim-pug',         {'for': 'pug'}
    Plug 'leafgarland/typescript-vim',  {'for': 'typescript'}
    Plug 'dbeniamine/todo.txt-vim',     {'for': 'todo'}
    Plug 'lervag/vimtex',               {'for': 'tex'}
call plug#end()
