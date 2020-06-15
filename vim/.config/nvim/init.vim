syntax on
filetype plugin indent on

" Encoding
set encoding=UTF-8

source ~/.config/nvim/plugins.vim
source ~/.config/nvim/functions.vim
source ~/.config/nvim/keybindings.vim
source ~/.config/nvim/config.vim

if LSPEnable()
  try
    luafile $HOME/.config/nvim/lua/init.lua
  endtry
end
