" Check if vim-pug is installed
let plugtarget = '~/.local/share/nvim/site/autoload/plug.vim'
if empty(glob(plugtarget))
  echo "Installing vim-plug..."
  try
    let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    call system('curl -fLo ' . plugtarget . ' --create-dirs ' . plugurl)
    autocmd VimEnter * PlugInstall
  catch
    echo "vim-plug couldn't be installed."
  endtry
endif

call plug#begin('~/.config/nvim/plugged')

" Enhancements builtin features
Plug 'voldikss/vim-floaterm'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'rstacruz/vim-closer'

" Git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" Visual
Plug 'itchyny/lightline.vim'
Plug 'Shougo/echodoc.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'morhetz/gruvbox'

" Fuzzy finder inside vim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'

" Wiki
Plug 'vimwiki/vimwiki'

" Go
Plug 'fatih/vim-go'

" Python
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

" Lisp
Plug 'guns/vim-sexp' | Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'junegunn/rainbow_parentheses.vim'

Plug 'Olical/aniseed', { 'tag': 'v3.2.0' }
Plug 'bakpakin/fennel.vim'

" Plug 'Olical/conjure', { 'tag': 'v2.1.1', 'do': 'bin/compile'  }

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

call plug#end()
