" New Start: A modern Arch workflow built with an emphasis on functionality.
" Copyright (C) 2017-2018 Donovan Glover

" Change the global leader to the space bar
let mapleader = ' '

" ================== Top row
nnoremap <silent> <leader>e :set nu!<CR>
nnoremap <silent> <leader>t :OverCommandLine<CR>%s/
" ================== Middle row
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>g :set hlsearch!<CR>
nnoremap <silent> <leader>j :Buffers<CR>
nnoremap <silent> <leader>l :Rg<CR>
" ================== Bottom row
autocmd FileType javascript nnoremap <silent> <leader>b :call JsBeautify()<CR>
autocmd FileType json       nnoremap <silent> <leader>b :call JsonBeautify()<CR>
autocmd FileType jsx        nnoremap <silent> <leader>b :call JsxBeautify()<CR>
autocmd FileType html       nnoremap <silent> <leader>b :call HtmlBeautify()<CR>
autocmd FileType css        nnoremap <silent> <leader>b :call CSSBeautify()<CR>

" Easily enter 'zen mode' with Goyo and Pencil (Note: Goyo resets the color scheme)
nnoremap <silent> <leader>2 :PencilSoft<CR>:Goyo<CR>:hi vertsplit ctermfg=0 ctermbg=none<CR>

" Save and load vim sessions
nnoremap <silent> <leader>3 :mksession! ~/.vim_session<CR>
nnoremap <silent> <leader>4 :source ~/.vim_session<CR>
