" Change the global leader to the space bar
let mapleader = ' '

" ================== Top row
"nnoremap <silent> <leader><TAB>
nnoremap <silent> <leader>q :Files<CR>
nnoremap <silent> <leader>w :Commits<CR>
nnoremap <silent> <leader>e :set nu!<CR>
nnoremap <silent> <leader>r :call matchadd('OverLength', '\%101v', 100)<CR>
nnoremap <silent> <leader>t :OverCommandLine<CR>%s/
nnoremap <silent> <leader>y :bn<CR>
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
