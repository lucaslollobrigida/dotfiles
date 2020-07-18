if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

setlocal comments=s1:/*,mb:*,ex:*/,://
setlocal commentstring=//\ %s

source $HOME/.config/nvim/common/eightspaceindent.vim

" use omni completion provided by lsp
" setlocal omnifunc=v:lua.vim.lsp.omnifunc
" autocmd CursorHold <buffer> lua vim.lsp.util.show_line_diagnostics()

compiler gcc
