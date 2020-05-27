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
Plug 'ncm2/float-preview.nvim'
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

" Completion engine
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" LSP and Completion engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Linter
Plug 'dense-analysis/ale'

" Wiki
Plug 'vimwiki/vimwiki'
Plug 'suan/vim-instant-markdown', {'for': 'markdown', 'do': 'npm -g install instant-markdown-d'}

" Lisp
Plug 'guns/vim-sexp' | Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'junegunn/rainbow_parentheses.vim'

" REPL development
Plug 'Olical/aniseed', { 'tag': 'v3.5.0' }
Plug 'bakpakin/fennel.vim'
Plug 'Olical/conjure', {'tag': 'v3.3.0'}

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

call plug#end()
