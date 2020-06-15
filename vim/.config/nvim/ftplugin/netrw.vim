let g:netrw_banner = 0
let g:netrw_home = expand('$XDG_DATA_HOME/vim')

nnoremap <buffer> <esc> :bp<cr>

function! s:rmdir()
  if input('delete '.fnamemodify(bufname(''),':p').getline('.').' ? (y/n)') ==# 'y'
    if !delete(fnamemodify(bufname(''),':p').getline('.'),'rf')
      if search('^\.\/$','Wb')
        exe "norm \<cr>"
      endif
    endif
  endif
endfunction
command! Rmnetrw call <SID>rmdir()

