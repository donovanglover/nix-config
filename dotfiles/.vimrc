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

source ~/.vim/plugins.vim
source ~/.vim/config.vim
source ~/.vim/colors.vim
source ~/.vim/ctags.vim
source ~/.vim/keybindings.vim

" =================================== Plugin-Specific ===================================

let g:ale_lint_on_text_changed = 'never'        " Do not lint while typing
let g:ale_lint_on_insert_leave = 1              " Only lint after leaving insert mode
let g:ackprg = 'rg --vimgrep'                   " Use rg instead of ag / ack / grep
let g:plug_window = 'rightbelow topleft new'    " Show vim-plug above instead of to the left
let g:vimfiler_as_default_explorer = 1          " Replace netrw with vimfiler as the default FileEx
let g:indentLine_enabled = 0                    " Disable indent lines by default
let g:indentLine_color_term = 8                 " Set the color for the indent line
"let g:vimfiler_no_default_key_mappings = 1

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
let g:vimtex_compiler_latexmk = {'build_dir': '.tex'}
map <localleader>a <plug>(vimtex-toc-toggle)
map <localleader>f <plug>(vimtex-view)
map <localleader>g <plug>(vimtex-compile)
map <localleader>c <plug>(vimtex-errors)
map <localleader>w :VimtexCountWords<CR>

" Delete the surrounding environment
map <localleader>d <plug>(vimtex-env-delete)
map <localleader>c <plug>(vimtex-env-change)

" Toggle stars
nnoremap <localleader>s <plug>(vimtex-env-toggle-star)
nnoremap <localleader>e <plug>(vimtex-cmd-toggle-star)

inoremap ]] <plug>(vimtex-delim-close)

" Use incsearch and tab / shift+tab to go through the results
cno <expr>  <tab>    getcmdtype() =~ '[?/]' ? '<c-g>' : feedkeys('<tab>', 'int')[1]
cno <expr>  <s-tab>  getcmdtype() =~ '[?/]' ? '<c-t>' : feedkeys('<s-tab>', 'int')[1]

" Easily repeat a command on multiple lines through visual mode
vnoremap . :normal .<CR>

" Easily show lines that go past the character count
highlight OverLength ctermbg=red ctermfg=white guibg=#592929

" Automatically close the file viewer when it's the only thing left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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
