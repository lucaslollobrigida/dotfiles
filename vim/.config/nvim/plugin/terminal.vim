" Remove lines from teminal buffer
augroup terminal_commands
    au!
    au BufEnter * if &buftype == "terminal" | startinsert | endif
    au TermOpen * setl nonumber norelativenumber
augroup END

