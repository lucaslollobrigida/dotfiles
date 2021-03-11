if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

setlocal autoindent
setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2
setlocal comments=n:;
setlocal commentstring=;;\ %s
setlocal iskeyword+=-,+,*,?,!,>,<,',#,/,:,.
