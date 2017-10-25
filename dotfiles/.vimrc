""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 
"    New Start: A modern Arch workflow built with an emphasis on functionality.
"    Copyright (C) 2017 Donovan Glover
" 
"    This program is free software: you can redistribute it and/or modify
"    it under the terms of the GNU General Public License as published by
"    the Free Software Foundation, either version 3 of the License, or
"    (at your option) any later version.
" 
"    This program is distributed in the hope that it will be useful,
"    but WITHOUT ANY WARRANTY; without even the implied warranty of
"    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"    GNU General Public License for more details.
" 
"    You should have received a copy of the GNU General Public License
"    along with this program.  If not, see <https://www.gnu.org/licenses/>.
" 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" =================================== Plugins ===================================

call plug#begin('~/.vim/plugged')       " Use vim-plug as our package manager of choice
    Plug 'osyo-manga/vim-over'          " Automatically highlight find and replace
    Plug 'jiangmiao/auto-pairs'         " Close brackets and other pairs automatically
    Plug 'sukima/xmledit'               " Automatically close tags when writing html
    Plug 'chriskempson/base16-vim'      " Add base16 color schemes
    Plug 'francoiscabrol/ranger.vim'    " Use ranger in vim
    Plug 'vim-syntastic/syntastic'      " Automatically check language syntax for errors
    Plug 'maksimr/vim-jsbeautify'       " Make it easier to work with foreign code
    Plug 'lervag/vimtex'                " Make editing LaTeX a breeze
    Plug 'dbeniamine/todo.txt-vim'      " Easily manage any part of your todo.txt
    Plug 'Kjwon15/vim-transparent'      " Add transparency by default for all color schemes
call plug#end()                         " Start the plugins

" =================================== Configuration ===================================

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

set incsearch                  " Automatically move to text as you search for it
set wildmenu                   " Show a menu of the different options when you tab in command mode
set display+=lastline          " Show as much of a long line as possible
set laststatus=0               " Never show the status line

set history=100                " Only keep the last 100 commands
set tabpagemax=50              " Set the maximum number of tabs to be opened in any window to 50
set viminfo^=!                 " Use viminfo to store workspace and other data automatically
set sessionoptions-=options    " When you explicitly save a workspace, save the entire environment

set t_Co=256                   " Tell vim that we want to use 256 colors
set term=xterm-256color        " Explicitly tell vim that our terminal supports 256 colors
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

" =================================== Plugin-Specific ===================================

let base16colorspace=256                        " Tell base16 to use 256 colors
source ~/.vimrc_background                      " Load the same base16 theme used in the shell

set statusline+=%#warningmsg#                   " Add warning message color
set statusline+=%{SyntasticStatuslineFlag()}    " Add the warning message
set statusline+=%*                              " Add the background color

let g:syntastic_always_populate_loc_list = 1    " Always show errors at the bottom
let g:syntastic_auto_loc_list = 1               " Open the error window automatically
let g:syntastic_check_on_open = 1               " Automatically check files when they're opened
let g:syntastic_check_on_wq = 0                 " Don't check files before exiting

let g:ranger_map_keys = 0                       " Remove the default ranger.vim keybindings

" =================================== Custom Keybindings ===================================

" Change the global leader to the space bar
let mapleader = ' '

" Easily open any file in a new tab with ranger
map <leader>f :RangerNewTab<CR>

" Toggle between highlighting all the search results
map <leader>g :set hlsearch!<CR>

" Find and replace with automatic highlighting and inline changes
map <leader>t :OverCommandLine<CR>%s/

" Insert a line above without leaving keybindings mode
map <leader>m O<Esc>

" Insert a line below without leaving keybindings mode
map <leader>n o<Esc>

" Save the current buffer
map <leader>j :w<CR>

" Close the current buffer
map <leader>k :q<CR>

" Toggle wrap
map <leader>w :set wrap!<CR>

" Toggle line numbers
map <leader>e :set nu!<CR>

" Easily switch between soft tabs and hard tabs
map <leader>v :set expandtab!<CR>

" Bind the right beautify function based on what file is open
autocmd FileType javascript map <leader>b :call JsBeautify()<CR>
autocmd FileType json       map <leader>b :call JsonBeautify()<CR>
autocmd FileType jsx        map <leader>b :call JsxBeautify()<CR>
autocmd FileType html       map <leader>b :call HtmlBeautify()<CR>
autocmd FileType css        map <leader>b :call CSSBeautify()<CR>

" Make it easy to disable and re-enable transparency as needed
map <leader>r :TransparentDisable<CR>
map <leader>y :TransparentEnable<CR>
