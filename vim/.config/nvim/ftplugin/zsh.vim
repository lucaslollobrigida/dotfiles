if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

" compiler shellcheck

setlocal expandtab
setlocal smartindent
setlocal shiftwidth=2
setlocal tabstop=2
setlocal comments=:#
setlocal commentstring=#\ %s
