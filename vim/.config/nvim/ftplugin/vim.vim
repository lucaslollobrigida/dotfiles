if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

source $HOME/.config/nvim/common/twospaceindent.vim

setlocal commentstring=\"\ %s

nnoremap <buffer> <leader>so :so %<cr>
