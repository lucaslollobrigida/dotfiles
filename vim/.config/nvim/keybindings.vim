" Leader keys
nnoremap <space> <nop>
let mapleader = "\<space>"
let maplocalleader = ","

" Disable EX-mode
nnoremap  Q <Nop>
nnoremap gQ <Nop>nnoremap <leader>, :w<CR>

" Command mode with one key
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" Save files with `sudo`
cmap w!! w !sudo tee > /dev/null %

" Window
nnoremap <C-+> <C-w>+
nnoremap <C-_> <C-w>-

" Buffers
nnoremap <leader>q :bprevious<CR>
nnoremap <leader>w :bnext<CR>
nnoremap <leader>c :bdelete!<CR>
nnoremap <leader>, :Buffers<cr>
nnoremap <leader>. :lcd %:p:h<CR>

" Netrw
nnoremap - :Explore<cr>

" Search
nnoremap <leader>s :Rg<CR>
nnoremap <leader>* :Rg <C-R>=expand("<cword>")<CR><CR>
nnoremap <silent> <leader>n :nohlsearch<CR>

" Files
nnoremap <leader>f :Files<cr>
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <leader><leader> :GFiles<cr>

" Tabs
nnoremap <leader>t :tabnew<CR>
nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprevious<CR>

" Sessions
nnoremap <leader>sw :mksession! .quicksave.vim<CR>:echo "Session saved."<CR>
nnoremap <leader>sr :source .quicksave.vim<CR>:echo "Session loaded."<CR>

" Terminal
" TODO: make this binding local to embedded terminal
tnoremap jk <c-\><c-n>
nnoremap <leader>sh :FloatermToggle<CR>

" Build and Run projects
nnoremap <leader>b :make<CR>
" nnoremap <leader>x :execute<CR>

" Format
nnoremap <leader>tw :call TrimWS()<CR>
nnoremap <leader>rt :call RemoveTabs()<CR>
