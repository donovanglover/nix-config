" New Start: A modern Arch workflow built with an emphasis on functionality.
" Copyright (C) 2017-2023 Donovan Glover

let plugsys = glob('/usr/share/vim/vimfiles/autoload/plug.vim')
let plugusr = glob('~/.vim/autoload/plug.vim')

if empty(plugsys) && empty(plugusr)
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/0.10.0/plug.vim
endif

let g:ale_disable_lsp = 1

autocmd FileType javascript let g:ale_linters = {
\  'javascript': glob('.eslintrc*', '.;') != '' ? [ 'eslint', 'flow' ] : [ 'standard', 'flow' ],
\}

call plug#begin('~/.vim/plugged')
    Plug 'dylanaraps/wal.vim'           " Color scheme
    Plug 'preservim/nerdtree'
    Plug 'airblade/vim-gitgutter'       " Git diff
    Plug 'itchyny/lightline.vim'        " Status line
    Plug 'dense-analysis/ale'           " Syntax checker
    Plug 'tpope/vim-fugitive'           " Git wrapper
    Plug 'junegunn/fzf.vim'             " fzf wrapper
    Plug 'lunarWatcher/auto-pairs'      " {Pair} completion
    Plug 'tpope/vim-endwise'            " 'End' completion
    Plug 'reedes/vim-pencil'            " Word wrap
    Plug 'junegunn/goyo.vim'            " Distraction-free writing
    Plug 'jparise/vim-graphql'          " GraphQL support
    Plug 'ryanoasis/vim-devicons'

    Plug 'osyo-manga/vim-over'
    Plug 'maksimr/vim-jsbeautify'

    Plug 'pangloss/vim-javascript'
    Plug 'rhysd/vim-crystal'
    Plug 'rust-lang/rust.vim'
    Plug 'baskerville/vim-sxhkdrc'
    Plug 'dag/vim-fish'
    Plug 'slim-template/vim-slim'
    Plug 'Glench/Vim-Jinja2-Syntax'
    Plug 'plasticboy/vim-markdown'
    Plug 'posva/vim-vue'
    Plug 'maxmellon/vim-jsx-pretty'
    Plug 'digitaltoad/vim-pug'
    Plug 'leafgarland/typescript-vim'
    Plug 'dbeniamine/todo.txt-vim'
    Plug 'lervag/vimtex'
    Plug 'pantharshit00/vim-prisma'
    Plug 'wuelnerdotexe/vim-astro'
    Plug 'isobit/vim-caddyfile'
call plug#end()

" ============================
" ========= settings =========
" ============================

filetype plugin indent on      " Attempt to determine the file type of extensionless files
syntax enable                  " Turn syntax highlighting on

set nocompatible               " Use vim defaults (i.e. ignore vi compatibility)
set backspace=indent,eol,start " Make the backspace key function as you would expect
set encoding=utf-8             " Always show files as utf-8
set fileencoding=utf-8         " Ensure that we always save files as utf-8
set fileencodings=utf-8,sjis   " Automatically open shiftjis files with their proper encoding

set autoindent                 " Automatically indent new lines
set ignorecase                 " By default use case-insensitive search (combine with smartcase)
set smartcase                  " Make search case-sensitive when using capital letters
set showcmd                    " Always show the current keybinding being executed
set spell                      " Enable spell check by default
set spelllang=en_us,cjk        " Don't show errors for CJK characters
set hidden                     " Switch between buffers without saving them

set incsearch                  " Automatically move to text as you search for it
set wildmenu                   " Show a menu of the different options when you tab in command mode
set display+=lastline          " Show as much of a long line as possible
set laststatus=2               " Enable the status line (set to 0 to remove)
set noshowmode                 " Disable the --MODE-- text (enable if not using the status line)

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
set number                     " Show numbers by default

" Disable middle button click
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>

" ==========================
" ========= colors =========
" ==========================

" Set the color scheme to wal, or install plugins as needed.
try
  colorscheme wal
catch /^Vim\%((\a\+)\)\=:E185/
  echo "wal was not found. Installing plugins...\n" | PlugInstall --sync
  echo "Plugins installed! You can now use vim.\n"  | qa
endtry

" Don't show the separator for vertical splits
highlight vertsplit ctermfg=0 ctermbg=none

" Finally, an easier way to read search results
highlight Search ctermbg=240 ctermfg=255
highlight IncSearch ctermbg=255 ctermfg=240

" Easily show lines that go past the character count
" highlight OverLength ctermbg=240 ctermfg=230
" call matchadd('OverLength', '\%80v')

autocmd BufNewFile,BufRead *.ecr    setlocal syntax=html
autocmd BufNewFile,BufRead *.slang  setlocal filetype=slim

" =============================
" ========= lightline =========
" =============================

" Add the current branch to the status line
let g:lightline = {
\   'active': {
\     'left': [
\       [ 'mode', 'paste' ], [ 'gitbranch' ],
\       ['readonly', 'filename', 'modified']
\     ]
\   },
\   'component_function': {
\     'gitbranch': 'fugitive#head'
\   }
\ }

" Note that wal.vim's lightline theme uses some options that are incompatible
" with regular vim and are only supported by neovim.
"
" Wal Themes: Tomorrow, Tomorrow_Night, one, materia, material, nord
" Other Themes: wombat, solarized, powerline, jellybeans, Tomorrow_Night_Blue,
"               Tomorrow_Night_Eighties, PaperColor, seoul256, landscape,
"               darcula, molokai, OldHope, deus
if has('nvim')
    let g:lightline.colorscheme = 'wal'
else
    let g:lightline.colorscheme = 'Tomorrow_Night'
endif

" Make background color of lightline match terminal
" https://github.com/itchyny/lightline.vim/issues/168
autocmd VimEnter * call SetupLightlineColors()
function SetupLightlineColors() abort
  " transparent background in statusbar
  let l:palette = lightline#palette()

  let l:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  let l:palette.inactive.middle = l:palette.normal.middle
  let l:palette.tabline.middle = l:palette.normal.middle

  call lightline#colorscheme()
endfunction

" ============================
" ========= keybinds =========
" ============================

" Use space as the global leader
let mapleader = ' '

" Top row
nnoremap <silent> <leader>e :set nu!<CR>
nnoremap <silent> <leader>t :OverCommandLine<CR>%s/

" Middle row
nnoremap <silent> <leader>a :Vexplore<CR>
nnoremap <silent> <leader>s :Sexplore<CR>
nnoremap <silent> <leader>d :Explore<CR>
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>g :set hlsearch!<CR>
nnoremap <silent> <leader>j :Buffers<CR>
nnoremap <silent> <leader>k :NERDTreeToggleVCS<CR>
nnoremap <silent> <leader>l :Rg<CR>
nnoremap <silent> <leader>; <C-w>w

" Bottom row
autocmd FileType javascript nnoremap <silent> <leader>b :call JsBeautify()<CR>
autocmd FileType json       nnoremap <silent> <leader>b :call JsonBeautify()<CR>
autocmd FileType jsx        nnoremap <silent> <leader>b :call JsxBeautify()<CR>
autocmd FileType html       nnoremap <silent> <leader>b :call HtmlBeautify()<CR>
autocmd FileType css        nnoremap <silent> <leader>b :call CSSBeautify()<CR>

" Experimental yomichan-like command with tango
vnoremap <C-s> y:silent !notify-send -t 4000 "成果" "$(tango '<C-r>0')"<CR>:<Esc>

" Easily enter 'zen mode' with Goyo and Pencil (Note: Goyo resets the color scheme)
nnoremap <silent> <leader>2 :PencilSoft<CR>:Goyo<CR>:hi vertsplit ctermfg=0 ctermbg=none<CR>

" Save and load vim sessions
nnoremap <silent> <leader>3 :mksession! ~/.vim/.session<CR>
nnoremap <silent> <leader>4 :source ~/.vim/.session<CR>

" Never worry about a directory not being created before saving
autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')

" =========================
" ========= netrw =========
" =========================

" Remove the banner
let g:netrw_banner = 0

" Use the tree list view
let g:netrw_liststyle = 3

" =======================
" ========= ale =========
" =======================

nmap <silent> <C-j> <Plug>(ale_previous_wrap)
nmap <silent> <C-k> <Plug>(ale_next_wrap)

" ==========================
" ========= vimtex =========
" ==========================

" Disable all keybinds so we can define our own
let g:vimtex_mappings_enabled = 0
let g:vimtex_imaps_enabled = 0
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_latexmk = {'build_dir': '.tex'}

" Set the normal keybinds
nnoremap <localleader>f <plug>(vimtex-view)
nnoremap <localleader>g <plug>(vimtex-compile)
nnoremap <localleader>d <plug>(vimtex-env-delete)
nnoremap <localleader>c <plug>(vimtex-env-change)

" ================================
" ========= vim-markdown =========
" ================================

" Disable vim-markdown folding
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math             = 1
let g:vim_markdown_frontmatter      = 1
autocmd BufNewFile,BufRead *.md set conceallevel=2

" Ignore syntax concealing for markdown files
let g:vim_markdown_conceal = 0
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" ============================
" ========= nerdtree =========
" ============================

let NERDTreeShowHidden=1

" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * silent! lcd %:p:h | NERDTreeVCS | wincmd p

" Exit if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

let NERDTreeStatusline='%{exists("b:NERDTree")?fnamemodify(b:NERDTree.root.path.str(), ":~"):""}'

" ===========================
" ========= fzf.vim =========
" ===========================

" Hide the status line showing "fzf" when using fzf.vim
" NOTE: You must add "showmode" if your setup depends on it
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 ruler
