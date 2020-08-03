" Remove lines from teminal buffer
augroup terminal_commands
    au!
    au BufEnter * if &buftype == "terminal" | startinsert | endif
    au TermOpen * setl nonumber norelativenumber
augroup END

lua require'terminal'.setup()

augroup floaterm_aucmds
  au!
  autocmd User Startified setlocal buflisted
augroup END

let g:floaterm_position = 'center'
let g:floaterm_background = '#252525'
let g:floaterm_border_color = '#555555'
let g:floaterm_border_bgcolor = '#141414'

let s:colors = [
  \'#1d1f21',
  \'#cc6666',
  \'#b5bd68',
  \'#f0c674',
  \'#81a2be',
  \'#b294bb',
  \'#8abeb7',
  \'#c5c8c6',
  \'#969896',
  \'#cc6666',
  \'#b5bd68',
  \'#f0c674',
  \'#81a2be',
  \'#b294bb',
  \'#8abeb7',
  \'#ffffff'
  \]

function! s:set_colors() abort
  let idx = 0
  for color_val in s:colors
    execute 'let b:terminal_color_' . string(idx) . '="' . color_val . '"'
    let idx = idx + 1
  endfor
endfunction

augroup terminal_aucmds
  au!
  autocmd TermOpen * call <SID>set_colors()
augroup END
