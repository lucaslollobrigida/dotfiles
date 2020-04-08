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

" Vim enhancements
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'voldikss/vim-floaterm'
Plug 'rstacruz/vim-closer'
Plug 'Shougo/echodoc.vim'

" Git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" Visual
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'danilo-augusto/vim-afterglow'
" Plug 'airblade/vim-gitgutter'

" Asynchronous fuzzyfinder for files/git/tags/buffers/greping
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Go
Plug 'fatih/vim-go'

" Python
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

" Clojure
Plug 'guns/vim-sexp' | Plug 'tpope/vim-sexp-mappings-for-regular-people'

" Depend on the latest version via tag.
Plug 'Olical/aniseed', { 'tag': 'v3.2.0' }

" For Fennel highlighting (based on Clojure).
Plug 'bakpakin/fennel.vim'

Plug 'junegunn/rainbow_parentheses.vim'
" Plug 'Olical/conjure', { 'tag': 'v2.1.1', 'do': 'bin/compile'  }

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

call plug#end()
