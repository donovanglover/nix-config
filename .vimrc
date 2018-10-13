" New Start: A modern Arch workflow built with an emphasis on functionality.
" Copyright (C) 2017-2018 Donovan Glover

if &shell =~# 'fish$'
  set shell=sh
endif

source ~/.vim/plugins.vim
source ~/.vim/config.vim
source ~/.vim/keybindings.vim

colorscheme wal

" Wal Themes: Tomorrow, Tomorrow_Night, one, materia, material, nord
" Other Themes: wombat, solarized, powerline, jellybeans, Tomorrow_Night_Blue,
"               Tomorrow_Night_Eighties, PaperColor, seoul256, landscape,
"               darcula, molokai, OldHope, deus
let g:lightline = {
\   'colorscheme': 'Tomorrow_Night',
\   'active': {
\     'left': [
\       [ 'mode', 'paste' ], [ 'gitbranch' ],
\       ['readonly', 'filename', 'modified']
\     ]
\   },
\   'component_function': {
\     'gitbranch': 'fugitive#head'
\   },
\ }

" =================================== Plugin-Specific ===================================

let g:ale_lint_on_text_changed = 'never'        " Do not lint while typing
let g:ale_lint_on_insert_leave = 1              " Only lint after leaving insert mode
let g:ale_linters = {'javascript': ['standard']}

" Don't show the separator for vertical splits
hi vertsplit ctermfg=0 ctermbg=none

" Finally, an easier way to read search results
hi Search ctermbg=240 ctermfg=255
hi IncSearch ctermbg=255 ctermfg=240

" Disable all vimtex keybindings so we can define our own
let g:vimtex_mappings_enabled = 0
let g:vimtex_imaps_enabled = 0
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_latexmk = {'build_dir': '.tex'}
nnoremap <localleader>f <plug>(vimtex-view)
nnoremap <localleader>g <plug>(vimtex-compile)
nnoremap <localleader>d <plug>(vimtex-env-delete)
nnoremap <localleader>c <plug>(vimtex-env-change)
inoremap ]] <plug>(vimtex-delim-close)

" Easily show lines that go past the character count
highlight OverLength ctermbg=240 ctermfg=230
call matchadd('OverLength', '\%80v')

autocmd BufNewFile,BufRead *.ecr    setlocal syntax=html
autocmd BufNewFile,BufRead *.slang  setlocal filetype=slim

" Disable vim-markdown folding
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math             = 1
let g:vim_markdown_frontmatter      = 1
autocmd BufNewFile,BufRead *.md set conceallevel=2

" Change cursor back to blink after exiting neovim
au VimLeave * set guicursor=a:block-blinkon1

" Ignore syntax concealing for markdown files
let g:vim_markdown_conceal = 0
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" Hide the status line showing "fzf" when using fzf.vim
" NOTE: You must add "showmode" if your setup depends on it
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 ruler
