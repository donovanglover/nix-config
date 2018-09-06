" New Start: A modern Arch workflow built with an emphasis on functionality.
" Copyright (C) 2017-2018 Donovan Glover

" Change the global leader to the space bar
let mapleader = ' '

" ================== Top row
nnoremap <silent> <leader>e :set nu!<CR>
nnoremap <silent> <leader>r :call matchadd('OverLength', '\%101v', 100)<CR>
nnoremap <silent> <leader>t :OverCommandLine<CR>%s/
nnoremap <silent> <leader>y :bn<CR>
nnoremap <silent> <leader>u <C-w>w
nnoremap <silent> <leader>i <C-w><C-p>
nnoremap <silent> <leader>o <C-d>
nnoremap <silent> <leader>p <C-u>
" ================== Middle row
"nnoremap <silent> <leader>a :NERDTreeToggle<CR>
nnoremap <silent> <leader>a :Files<CR>
"nnoremap <silent> <leader>d :TagbarToggle<CR>
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>g :set hlsearch!<CR>
" Easily jump between lines in all open files
nnoremap <silent> <leader>j :Buffers<CR>
nnoremap <silent> <leader>k :Lines<CR>
" This is the same as f, but I haven't figured out which
" letter I like using better yet
nnoremap <silent> <leader>l :Files<CR>
" Easily open new files in horizontal and vertical splits
nnoremap <silent> <leader>; :split<CR> <C-w>w :Files<CR>
nnoremap <silent> <leader>' :vsplit<CR> <C-w>w :Files<CR>
" ================== Bottom row
nnoremap <silent> <leader>v :Ack! "\b<cword>\b"<CR>
nnoremap <silent> <leader>n o<Esc>
nnoremap <silent> <leader>m O<Esc>

" Bind the right beautify function based on what file is open
autocmd FileType javascript nnoremap <silent> <leader>b :call JsBeautify()<CR>
autocmd FileType json       nnoremap <silent> <leader>b :call JsonBeautify()<CR>
autocmd FileType jsx        nnoremap <silent> <leader>b :call JsxBeautify()<CR>
autocmd FileType html       nnoremap <silent> <leader>b :call HtmlBeautify()<CR>
autocmd FileType css        nnoremap <silent> <leader>b :call CSSBeautify()<CR>

" Easily enter 'zen mode' with Goyo and Pencil
" We have to explicitly set vertsplit again since Goyo resets it for some reason
nnoremap <silent> <leader>2 :PencilSoft<CR>:Goyo<CR>:hi vertsplit ctermfg=8 ctermbg=none<CR>
nnoremap <silent> <leader>3 :mksession! ~/.vim_session<CR>
nnoremap <silent> <leader>4 :source ~/.vim_session<CR>

" Close the current buffer without closing the window
" Useful for when you want to close a buffer with VimFiler open
nnoremap <silent> <leader>5 :bp<bar>sp<bar>bn<bar>bd<CR>
