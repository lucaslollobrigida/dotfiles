" Plugin management with vim-plug
" Author: Lucas Lollobrigida
" Repository: https://github.com/lucaslollobrigida/dotfiles
"
" I'm trying to avoid external depenpencies besides lua that's embedded 
" in neovim, so any plugins that depends on python or node.js provider

" Check if vim-pug is installed
let plugtarget = '~/.local/share/nvim/site/autoload/plug.vim'
if empty(glob(plugtarget))
  echom "Installing vim-plug..."
  try
    let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    call system('curl -fLo ' . plugtarget . ' --create-dirs ' . plugurl)
    autocmd VimEnter * PlugInstall
  catch
    echo "vim-plug couldn't be installed."
  endtry
endif

if !exists("$XDG_CONFIG_HOME")
  call plug#begin("$HOME/.config/nvim/plugged")
else
  call plug#begin("$XDG_CONFIG_HOME/nvim/plugged")
endif

" Visual
Plug 'itchyny/lightline.vim'
Plug 'sainnhe/sonokai'
Plug 'mhinz/vim-signify'
Plug 'ryanoasis/vim-devicons'
Plug 'ncm2/float-preview.nvim'
Plug 'norcalli/nvim-terminal.lua'

" Editing
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'

" Project
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-dispatch' | Plug 'radenling/vim-dispatch-neovim'

" Fuzzy finder inside vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'

" Git wrapper
Plug 'tpope/vim-fugitive'
" Plug 'jreybert/vimagit'

" Wiki
Plug 'vimwiki/vimwiki'

" Floating Terminal
Plug 'voldikss/vim-floaterm'

" Snippets
Plug 'SirVer/ultisnips'

" LSP
" Note: this feature isn't in the stable neovim realease yet, so it expected to have bugs
" Plug 'neovim/nvim-lsp'
" Plug 'haorenW1025/completion-nvim' | Plug 'haorenW1025/diagnostic-nvim'

" LSP Engine
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Needs node provider :(

" Lisp
Plug 'guns/vim-sexp' | Plug 'tpope/vim-sexp-mappings-for-regular-people'

" Clojure
" Plug 'tpope/vim-fireplace'
Plug 'Olical/conjure', {'tag': 'v3.5.0'} | Plug 'Olical/AnsiEsc'

call plug#end()
