" Current configuration based on Coc for LSP
" Author: Lucas Lollobrigida
" Repository: https://github.com/lucaslollobrigida/dotfiles

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

call plug#begin('~/.local/share/nvim/plugged')

" Visual
Plug 'sainnhe/sonokai'
Plug 'mhinz/vim-signify'
Plug 'ryanoasis/vim-devicons'
Plug 'ncm2/float-preview.nvim'
Plug 'norcalli/nvim-terminal.lua'

" Statusline
" Local version for now ...
Plug '~/dev/lua/express_line.nvim/'

" Focus Mode
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Async jobs
Plug 'tjdevries/luvjob.nvim'

" Editing
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'

" Project
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-dispatch' | Plug 'radenling/vim-dispatch-neovim'
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'

" tab management
Plug 'm00qek/nvim-contabs'

" REPL integration
Plug 'clojure-vim/vim-jack-in'
Plug 'Olical/conjure', { 'tag': 'v4.2.0' } | Plug 'Olical/AnsiEsc'

" Static analyses
Plug 'm00qek/nvim-lsp' "waiting until neovim/nvim-lsp merges PR #305
Plug 'nvim-lua/diagnostic-nvim'
Plug 'nvim-lua/lsp-status.nvim'

" Completion
Plug 'nvim-lua/completion-nvim'
Plug 'm00qek/completion-conjure'

"rainbow parentheses
Plug 'luochen1990/rainbow'

" structural edition
Plug 'guns/vim-sexp' | Plug 'tpope/vim-sexp-mappings-for-regular-people'

" Git
Plug 'tpope/vim-fugitive'

" Floating Terminal
Plug 'voldikss/vim-floaterm'

" Wiki
Plug 'vimwiki/vimwiki'

" Syntax
Plug 'guns/vim-clojure-static'
Plug 'dart-lang/dart-vim-plugin'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'LnL7/vim-nix'
Plug 'euclidianAce/BetterLua.vim'

" Snippets
Plug 'hrsh7th/vim-vsnip' | Plug 'hrsh7th/vim-vsnip-integ'

" TreeSitter
" Plug 'nvim-treesitter/nvim-treesitter'

" Lua development ...
" Plug 'tjdevries/nlua.nvim'

call plug#end()
