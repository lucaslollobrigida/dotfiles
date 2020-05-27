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

" Files
nnoremap <leader><leader> :GFiles<cr>
nnoremap <leader>fs :Files<cr>
nnoremap <leader>fe :e <C-R>=expand("%:p:h") . "/" <CR>

" Buffers
nnoremap <localleader><localleader> :w!<CR>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>q :bprevious<CR>
nnoremap <leader>w :bnext<CR>
nnoremap <leader>c :bdelete!<CR>
nnoremap <leader>bs :so %<CR>
nnoremap <leader>bo :call <SID>delete_hidden_buffers()<CR>
nnoremap <leader>. :lcd %:p:h<CR>

" Windows
nnoremap <leader>o :only<cr>

" Tabs
nnoremap <leader>t :tabnew<CR>
nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprevious<CR>

" Search
nnoremap <leader>s :Rg<CR>
nnoremap <leader>sg :Rg<CR>
nnoremap <silent> <leader>n :nohlsearch<CR>

" Format
nnoremap <leader>tw :call <SID>trim_trailing_whitespace()<CR>
nnoremap <leader>rt :call <SID>remove_tabs()<CR>

" Terminal
nnoremap <leader>sh :FloatermToggle<CR>
" tnoremap <Esc><Esc> :FloatermToggle<CR>
tnoremap jk <c-\><c-n>

" Sessions
nnoremap <leader>sw :mksession! .quicksave.vim<CR>:echo "Session saved."<CR>
nnoremap <leader>sr :source .quicksave.vim<CR>:echo "Session loaded."<CR>

" COC
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:delete_hidden_buffers()
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    silent execute 'bwipeout' buf
  endfor
endfunction

function! s:trim_trailing_whitespace()
  %s/\s\+$//e
endfunction

function! s:remove_tabs()
  %s/\t/  /ge
endfunction

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! Expand(exp) abort
    let l:result = expand(a:exp)
    return l:result ==# '' ? '' : "file://" . l:result
endfunction
