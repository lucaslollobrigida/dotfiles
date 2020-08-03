syntax on
filetype plugin indent on

" Encoding
set encoding=UTF-8

if has('nvim-0.5')
  source ~/.config/nvim/native_lsp.vim
else
  source ~/.config/nvim/coc_config.vim
end
