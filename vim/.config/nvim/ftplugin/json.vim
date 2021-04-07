if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

setlocal expandtab
setlocal smartindent
setlocal shiftwidth=2
setlocal tabstop=2
setlocal comments=s1:/*,mb:*,ex:*/,://
setlocal commentstring=//\ %s
