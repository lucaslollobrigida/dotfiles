if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

setlocal expandtab
setlocal smartindent
setlocal shiftwidth=8
setlocal tabstop=8
setlocal comments=s1:/*,mb:*,ex:*/,://
setlocal commentstring=//\ %s

compiler gcc
