if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

setlocal expandtab
setlocal smartindent
setlocal autoindent

setlocal shiftwidth=0
setlocal tabstop=4
setlocal softtabstop=4

setlocal comments=:#
setlocal commentstring=#\ %s

" compiler shellcheck