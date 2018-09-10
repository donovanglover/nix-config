" New Start: A modern Arch workflow built with an emphasis on functionality.
" Copyright (C) 2017-2018 Donovan Glover
"
filetype plugin indent on      " Attempt to determine the file type of extensionless files
syntax enable                  " Turn syntax highlighting on

set nocompatible               " Use vim defaults (i.e. ignore vi compatibility)
set backspace=indent,eol,start " Make the backspace key function as you would expect
set encoding=utf-8             " Always show files as utf-8
set fileencoding=utf-8         " Ensure that we always save files as utf-8

set autoindent                 " Automatically indent new lines
set ignorecase                 " By default use case-insensitive search (combine with smartcase)
set smartcase                  " Make search case-sensitive when using capital letters
set showcmd                    " Always show the current keybinding being executed
set spell                      " Enable spell check by default
set hidden                     " Switch between buffers without saving them

set incsearch                  " Automatically move to text as you search for it
set wildmenu                   " Show a menu of the different options when you tab in command mode
set display+=lastline          " Show as much of a long line as possible
set laststatus=0               " Disable the status line (removes filename and increases working space)

set history=100                " Only keep the last 100 commands
set tabpagemax=50              " Set the maximum number of tabs to be opened in any window to 50
set viminfo^=!                 " Use viminfo to store workspace and other data automatically
set sessionoptions-=options    " When you explicitly save a workspace, save the entire environment

set t_Co=256                   " Tell vim that we want to use 256 colors
set scrolloff=1                " The minimal number of rows to show when scrolling up/down
set sidescrolloff=5            " The minimal number of columns to show when scrolling left/right

set undofile                   " Keep track of undos even after you close a file
set undodir=~/.vim/undo        " Save the undo history here (not that the directory must exist)
set undolevels=1000            " We can undo this many times
set undoreload=10000           " The maximum number of lines to keep in the undo file

set tabstop=4                  " Show a tab character as 4 spaces
set softtabstop=0              " Edit soft tabs as if they're regular spaces
set shiftwidth=4               " Make autoindent appear as 4 spaces

set expandtab                  " When using <Tab>, replace the tab character with 4 spaces
set smarttab                   " Always indent based on column number to align things easier

set mouse=a                    " Enable mouse support in (a)ll modes
