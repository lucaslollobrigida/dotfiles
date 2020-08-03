" Clipboard
silent! set clipboard=unnamed
silent! set clipboard+=unnamedplus

" Must have visual information
silent! set relativenumber number cursorline noshowmode

" Better split default
silent! set splitbelow splitright

" Faster vim experience
silent! set updatetime=200 timeout timeoutlen=500 ttimeout ttimeoutlen=50 ttyfast lazyredraw

" Completion configuration to edit text with sanity
set completeopt+=noinsert,noselect,menuone
set shortmess+=c

" Disable defautl stuff
let g:loaded_2html_plugin = 1
let g:loaded_gzip = 1
let g:loaded_tarPlugin = 1
let g:loaded_zipPlugin = 1

" Some default ignores
silent! set wildignore=*.~,*.?~,*.o,*.sw?,*.bak,*.hi,*.pyc,*.out,*.lock,*.jar suffixes=*.pdf

" Auto save before changing context and autoload write from file to buffer
silent! set autoread autowrite " TODO: move this to ft to prevent watching unnecessary files

" " Folding
" silent! set foldclose=all foldcolumn=0 nofoldenable foldlevel=0 foldmarker& foldmethod=indent " TODO: move this to filetypes

let $VIM_CACHE = expand('$XDG_CACHE_HOME/vim')

" Editing
silent! set hidden nowrap undofile undolevels=1000 undodir=$VIM_CACHE/undo,/var/tmp/vim,/var/tmp

" Visuals
" silent! set textwidth=0 backspace=indent,eol,start nrformats=hex formatoptions=cmMj nojoinspaces
" silent! set nolinebreak mouse= modeline&

" Cache
silent! set history=10000 viminfo='10,/100,:10000,<10,@10,s10,h,n$VIM_CACHE/viminfo
silent! set swapfile directory=$VIM_CACHE/swap,/var/tmp/vim,/var/tmp
silent! set backup backupdir=$VIM_CACHE/backup,/var/tmp/vim,/var/tmp

" " Search
silent! set inccommand=split

" Auto commands
augroup vimrc
  autocmd!
augroup END

" Always open read-only when a swap file is found
autocmd vimrc SwapExists * let v:wapchoice = 'o'
