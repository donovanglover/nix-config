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
    Plug 'airblade/vim-gitgutter'
    Plug 'osyo-manga/vim-over'          " Automatically highlight find and replace
    Plug 'jiangmiao/auto-pairs'         " Close brackets and other pairs automatically
    Plug 'sukima/xmledit'               " Automatically close tags when writing html
    Plug 'w0rp/ale'                     " Automatically check language syntax for errors
    Plug 'maksimr/vim-jsbeautify'       " Make it easier to work with foreign code
    Plug 'lervag/vimtex'                " Make editing LaTeX a breeze
    Plug 'dbeniamine/todo.txt-vim'      " Easily manage any part of your todo.txt
    Plug 'Kjwon15/vim-transparent'      " Add transparency by default for all color schemes
    Plug 'elixir-editors/vim-elixir'    " Add syntax highlighting and autoindent for Elixir

    Plug 'tpope/vim-fugitive'           " Add fugitive.vim, enabling us to use git in vim
    Plug 'junegunn/fzf'                 " Add fuzzy finding to easily move between files
    Plug 'junegunn/fzf.vim'             " Add the vim functionality of fuzzy finding

    Plug 'rhysd/vim-crystal'            " Add support for the crystal language
    Plug 'scrooloose/nerdtree'          " Add a file browser to vim

    Plug 'majutsushi/tagbar'            " Add tagbar to show functions on the side
    Plug 'lvht/tagbar-markdown'         " Add support for markdown to tagbar

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
set spell                      " Enable spell check by default

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

" =================================== Plugin-Specific ===================================

let base16colorspace=256                        " Tell base16 to use 256 colors
" source ~/.vimrc_background                      " Load the same base16 theme used in the shell
source ~/Home/Contributing/base16-vim/colors/base16-atelier-cave-light.vim

let g:ale_lint_on_text_changed = 'never'        " Do not lint while typing
let g:ale_lint_on_insert_leave = 1              " Only lint after leaving insert mode
let g:ackprg = 'ag --vimgrep'                   " Use ag instead of ack / grep
let g:plug_window = 'rightbelow topleft new'    " Show vim-plug above instead of to the left
let g:vimfiler_as_default_explorer = 1          " Replace netrw with vimfiler as the default FileEx
let g:indentLine_enabled = 0                    " Disable indent lines by default
let g:indentLine_color_term = 8                 " Set the color for the indent line
let g:vimfiler_no_default_key_mappings = 1

" Note that indent lines breaks with pencil mode, although you really
" shouldn't be using both at the same time anyway.

" NOTE: To view all the items you can change the color of, use:
" :so $VIMRUNTIME/syntax/hitest.vim

" Set the color for the vertical split line (6 is as good as 8 here)
hi vertsplit ctermfg=8 ctermbg=none
" Remove the background color from the status line
hi StatusLine ctermbg=none
hi StatusLineNC ctermbg=none
" Remove the background color from tabs
hi TabLine ctermbg=none
hi TabLineFill ctermbg=none
hi TabLineSel ctermbg=none
" Finally, an easier way to read search results
hi Search ctermbg=240 ctermfg=255
" We have to set the color for while we search as well
" To keep things simple, we'll just invert the colors here
" As an added bonus, this looks rather nice as well
hi IncSearch ctermbg=255 ctermfg=240

" Disable all vimtex keybindings so we can define our own
let g:vimtex_mappings_enabled = 0
let g:vimtex_imaps_enabled = 0
let g:vimtex_view_method = 'zathura'
let g:vimtex_index_show_help = 0
let g:vimtex_index_split_width = 50
let g:vimtex_index_split_pos = 'vert rightbelow'
nnoremap <localleader>a <plug>(vimtex-toc-toggle)
nnoremap <localleader>f <plug>(vimtex-view)
nnoremap <localleader>g <plug>(vimtex-compile)
nnoremap <localleader>c <plug>(vimtex-errors)
nnoremap <localleader>w :VimtexCountWords<CR>

" Delete the surrounding environment
nnoremap <localleader>d <plug>(vimtex-env-delete)
nnoremap <localleader>c <plug>(vimtex-env-change)

" Toggle stars
nnoremap <localleader>s <plug>(vimtex-env-toggle-star)
nnoremap <localleader>e <plug>(vimtex-cmd-toggle-star)

inoremap ]] <plug>(vimtex-delim-close)

" =================================== Custom Keybindings ===================================

" Change the global leader to the space bar
let mapleader = ' '

" Use incsearch and tab / shift+tab to go through the results
cno <expr>  <tab>    getcmdtype() =~ '[?/]' ? '<c-g>' : feedkeys('<tab>', 'int')[1]
cno <expr>  <s-tab>  getcmdtype() =~ '[?/]' ? '<c-t>' : feedkeys('<s-tab>', 'int')[1]

" Easily repeat a command on multiple lines through visual mode
vnoremap . :normal .<CR>

" Easily show lines that go past the character count
highlight OverLength ctermbg=red ctermfg=white guibg=#592929

" Automatically close the file viewer when it's the only thing left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Add elixir support to ctags
let g:tagbar_type_elixir = {
    \ 'ctagstype' : 'elixir',
    \ 'kinds' : [
        \ 'f:functions',
        \ 'functions:functions',
        \ 'c:callbacks',
        \ 'd:delegates',
        \ 'e:exceptions',
        \ 'i:implementations',
        \ 'a:macros',
        \ 'o:operators',
        \ 'm:modules',
        \ 'p:protocols',
        \ 'r:records',
        \ 't:tests'
    \ ]
\ }

" Add rust support to ctags
let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds' : [
        \'T:types,type definitions',
        \'f:functions,function definitions',
        \'g:enum,enumeration names',
        \'s:structure names',
        \'m:modules,module names',
        \'c:consts,static constants',
        \'t:traits',
        \'i:impls,trait implementations',
    \]
\}

" Add crystal support to ctags
let g:tagbar_type_crystal = {
    \'ctagstype': 'crystal',
    \'ctagsbin': 'crystalctags',
    \'kinds': [
        \'c:classes',
        \'m:modules',
        \'d:defs',
        \'x:macros',
        \'l:libs',
        \'s:sruct or unions',
        \'f:fun'
    \],
    \'sro': '.',
    \'kind2scope': {
        \'c': 'namespace',
        \'m': 'namespace',
        \'l': 'namespace',
        \'s': 'namespace'
    \},
\}

" Use w!! to force write a file as sudo
" cmap w!! w !sudo tee > /dev/null %

" Make the tabline not have an X in it
function MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " select the highlighting
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif

        " set the tab page number (for mouse clicks)
        let s .= '%' . (i + 1) . 'T'

        " the label is made by MyTabLabel()
        let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'

    return s
endfunction

function MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    return bufname(buflist[winnr - 1])
endfunction

set tabline=%!MyTabLine()

" Custom highlighting
" Highlight key words that we like to use
match Function /@requires/

" Use syntax highlighting for .ecr files
autocmd BufNewFile,BufRead *.ecr set syntax=html

" Easily switch between buffers
nnoremap <silent> gn :bn<CR>
nnoremap <silent> gp :bp<CR>
nnoremap <silent> gd :bd<CR>
" ================== Top row
"nnoremap <silent> <leader><TAB>
nnoremap <silent> <leader>q :Files<CR>
nnoremap <silent> <leader>w :Commits<CR>
nnoremap <silent> <leader>e :set nu!<CR>
nnoremap <silent> <leader>r :call matchadd('OverLength', '\%101v', 100)<CR>
nnoremap <silent> <leader>t :OverCommandLine<CR>%s/
"nnoremap <silent> <leader>y
nnoremap <silent> <leader>u <C-w>w
nnoremap <silent> <leader>i <C-w><C-p>
nnoremap <silent> <leader>o <C-d>
nnoremap <silent> <leader>p <C-u>
" Easily show all git diffs
nnoremap <silent> <leader>[ :GFiles?<CR>
" Easily show all git files
nnoremap <silent> <leader>] :GFiles<CR>
" Easily go through all the commits for a specific file
nnoremap <silent> <leader>\ :BCommits<CR>
" ================== Middle row
nnoremap <silent> <leader>a :NERDTreeToggle<CR>
"nnoremap <silent> <leader>s
nnoremap <silent> <leader>d :TagbarToggle<CR>
nnoremap <silent> <leader>f :VimFiler<CR>
nnoremap <silent> <leader>g :set hlsearch!<CR>
nnoremap <silent> <leader>h :Buffers<CR>
" Easily jump between lines in all open files
nnoremap <silent> <leader>j :Lines<CR>
" Easily jump between lines in the same file
nnoremap <silent> <leader>k :BLines<CR>
" Easily search for any line in all files in the project
nnoremap <silent> <leader>l :Ag<CR>
" Easily open new files in horizontal and vertical splits
nnoremap <silent> <leader>; :split<CR> <C-w>w :Files<CR>
nnoremap <silent> <leader>' :vsplit<CR> <C-w>w :Files<CR>
" ================== Bottom row
" Note that I personally don't use <space> + z/x/c/n/m/,/.
nnoremap <silent> <leader>v :Ack! "\b<cword>\b"<CR>
"nnoremap <silent> <leader>b
nnoremap <silent> <leader>n o<Esc>
nnoremap <silent> <leader>m O<Esc>

" Bind the right beautify function based on what file is open
autocmd FileType javascript map <leader>b :call JsBeautify()<CR>
autocmd FileType json       map <leader>b :call JsonBeautify()<CR>
autocmd FileType jsx        map <leader>b :call JsxBeautify()<CR>
autocmd FileType html       map <leader>b :call HtmlBeautify()<CR>
autocmd FileType css        map <leader>b :call CSSBeautify()<CR>

" Easily enter 'zen mode' with Goyo and Pencil
" We have to explicitly set vertsplit again since Goyo resets it for some reason
nnoremap <silent> <leader>2 :PencilSoft<CR>:Goyo<CR>:hi vertsplit ctermfg=8 ctermbg=none<CR>
nnoremap <silent> <leader>3 :mksession! ~/.vim_session<CR>
nnoremap <silent> <leader>4 :source ~/.vim_session<CR>
nnoremap <silent> <leader>8 :15winc -<CR>
nnoremap <silent> <leader>9 :15winc +<CR>
nnoremap <silent> <leader>0 :winc =<CR>
