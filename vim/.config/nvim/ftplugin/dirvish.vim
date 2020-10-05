setlocal nonumber
setlocal norelativenumber

nnoremap <buffer> D :Shdo rm -r {}<CR>
nnoremap <buffer> d :!mkdir -p <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <buffer> R :Shdo mv {}<space>
