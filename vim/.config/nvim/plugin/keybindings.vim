" leader keys
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
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

" Buffers
nnoremap <leader>q :bprevious<CR>
nnoremap <leader>w :bnext<CR>
nnoremap <leader>c :bdelete!<CR>
nnoremap <leader>, :Buffers<cr>
nnoremap <leader>. :lcd %:p:h<CR>

" Search
nnoremap <leader>s :Rg<CR>
nnoremap <leader>* :Rg <C-R>=expand("<cword>")<CR><CR>
" nnoremap <leader>* :Rg <C-R><C-A><CR>
nnoremap <silent> <leader>n :nohlsearch<CR>

" Files
nnoremap <leader>f :Files<CR>
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <leader><leader> :GFiles<cr>

" Tabs
nnoremap <leader>t :tabnew<CR>
nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprevious<CR>

" Project
nnoremap <silent> <leader>p :call contabs#project#select()<CR>
nnoremap <silent> <leader>, :call contabs#buffer#select()<CR>

" Sessions
nnoremap <leader>sw :mksession! .quicksave.vim<CR>:echo "Session saved."<CR>
nnoremap <leader>sr :source .quicksave.vim<CR>:echo "Session loaded."<CR>

" Terminal
" TODO: make this binding local to embedded terminal
tnoremap jk <c-\><c-n>
nnoremap <leader>sh :FloatermToggle<CR>

" Build and Run projects
" nnoremap <leader>b :Make<CR>
" nnoremap <leader>x :execute<CR>

" Format
nnoremap <leader>tw :call TrimWS()<CR>
nnoremap <leader>rt :call RemoveTabs()<CR>

xnoremap  <   <gv
xnoremap  >   >gv

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-references)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> [d <Plug>(coc-declarations)
nmap <silent> gW :<C-u>CocList -I symbols<cr>

nmap <leader>rn <Plug>(coc-rename)
nmap <leader>rf <Plug>(coc-refactor)
nnoremap <leader>rp :CocSearch <C-R>=expand("<cword>")<CR><CR>
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

nnoremap <silent> K :call ShowDocumentation()<CR>

" code action
vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>aa <Plug>(coc-codeaction)
nmap <leader>aq <Plug>(coc-fix-current)
nmap <silent> <leader>d :<C-u>CocList diagnostics<cr>

" Test
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
nmap <C-m> vi{ga-<Space>
" nmap <C-M> vi[ga-<Space><CR>

nnoremap <silent> crcc :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'cycle-coll', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crth :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-first', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crtt :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-last', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crtf :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-first-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crtl :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-last-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cruw :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'unwind-thread', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crua :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'unwind-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crml :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'move-to-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Binding name: ')]})<CR>
nnoremap <silent> cril :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'introduce-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Binding name: ')]})<CR>
nnoremap <silent> crel :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'expand-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cram :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'add-missing-libspec', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crcn :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'clean-ns', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crcp :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'cycle-privacy', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cris :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'inline-symbol', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cref :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'extract-function', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Function name: ')]})<CR>
