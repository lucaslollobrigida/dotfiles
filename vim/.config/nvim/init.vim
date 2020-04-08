if filereadable(expand('$XDG_CONFIG_HOME/nvim/plugins.vim'))
  source ~/.config/nvim/plugins.vim
endif

" Set default paths
let $VIM_DATA = $XDG_DATA_HOME . '/vim'
let $VIM_CACHE = $XDG_CACHE_HOME . '/vim'

" Encoding
set encoding=UTF-8

set signcolumn=yes
set termguicolors
if !has('gui_running')
  set t_Co=256
endif

" Clipboard
silent! set clipboard=unnamed
silent! set clipboard+=unnamedplus

" Appearance
silent! set relativenumber number background=dark display=lastline,uhex wrap wrapmargin=0 key= t_Co=256
silent! set noshowmatch matchtime=1 noshowmode shortmess+=I cmdheight=1 cmdwinheight=10 showbreak=
silent! set noshowcmd noruler rulerformat= laststatus=2 statusline=%t\ %=\ %m%r%y%w\ %3l:%-2c
silent! set title titlelen=100 titleold= titlestring=%f noicon norightleft showtabline=1
silent! set cursorline nocursorcolumn colorcolumn= concealcursor=nvc conceallevel=0 norelativenumber
silent! set list listchars=tab:>\ ,nbsp:_ synmaxcol=3000 ambiwidth=double breakindent breakindentopt=
silent! set nosplitbelow nosplitright nostartofline linespace=0 whichwrap=b,s scrolloff=0 sidescroll=0
silent! set equalalways nowinfixwidth nowinfixheight winminwidth=3 winminheight=3 nowarn noconfirm
silent! set fillchars=vert:\|,fold:\  eventignore= helplang=en viewoptions=options,cursor virtualedit=
silent! let [&t_SI,&t_EI] = exists('$TMUX') ? ["\ePtmux;\e\e[5 q\e\\","\ePtmux;\e\e[2 q\e\\"] : ["\e]50;CursorShape=1\x7","\e]50;CursorShape=0\x7"]
silent! let [&t_PS, &t_PE, &t_BE, &t_BD] = ["\e[200~", "\e[201~", "\e[?2004h", "\e[?2004l"]

" Editing
silent! set iminsert=0 imsearch=0 nopaste pastetoggle= nogdefault comments& commentstring=#\ %s
silent! set smartindent autoindent shiftround shiftwidth=2 expandtab tabstop=2 smarttab softtabstop=2
silent! set foldclose=all foldcolumn=0 nofoldenable foldlevel=0 foldmarker& foldmethod=indent
silent! set textwidth=0 backspace=indent,eol,start nrformats=hex formatoptions=cmMj nojoinspaces
silent! set nohidden autoread noautowrite noautowriteall nolinebreak mouse= modeline& modelines&
silent! set noautochdir write nowriteany writedelay=0 verbose=0 verbosefile= notildeop noinsertmode
silent! set tags=tags,./tags,../tags,../../tags,../../../tags,../../../../tags,../../../../../tags
silent! set tags+=../../../../../../tags,../../../../../../../tags
silent! set tags+=$VIM_CACHE/tags

" Cache
let g:netrw_home = '$VIM_DATA'
silent! set history=10000 viminfo='10,/100,:10000,<10,@10,s10,h,n$VIM_CACHE/viminfo
silent! set nospell spellfile=$VIM_DATA/en.utf-8.add
silent! set swapfile directory=$VIM_CACHE/swap,/var/tmp/vim,/var/tmp
silent! set nobackup backupdir=$VIM_CACHE/backup,/var/tmp/vim,/var/tmp
silent! set undofile undolevels=1000 undodir=$VIM_CACHE/undo,/var/tmp/vim,/var/tmp

" Search
silent! set wrapscan ignorecase smartcase incsearch hlsearch magic

" Insert completion
silent! set complete& completeopt=menu infercase pumheight=10 noshowfulltag shortmess+=c

" Command line
silent! set wildchar=9 nowildmenu wildmode=list:longest wildoptions= wildignorecase cedit=<C-k>
silent! set wildignore=*.~,*.?~,*.o,*.sw?,*.bak,*.hi,*.pyc,*.out,*.lock suffixes=*.pdf

" Performance
silent! set updatetime=300 timeout timeoutlen=500 ttimeout ttimeoutlen=50 ttyfast lazyredraw

" Bell
silent! set noerrorbells visualbell t_vb=

" Split defaults
set splitbelow splitright
" set hidden
" set ruler

" set winbl=10

filetype plugin indent on
syntax on
" set wildmenu

" Auto commands
augroup vimrc
  autocmd!
augroup END

" Move to the directory each buffer
autocmd vimrc BufEnter * silent! lcd %:p:h

" Open quickfix window automatically
autocmd vimrc QuickfixCmdPost [^l]* nested copen | wincmd p
autocmd vimrc QuickfixCmdPost l* nested lopen | wincmd p

" Close quickfix window when it is the only window
autocmd vimrc WinEnter * if &l:buftype ==# 'quickfix' && winnr('$') == 1 | quit | endif

" Fix window position of help
autocmd vimrc FileType help if &l:buftype ==# 'help' | wincmd K | endif

" Always open read-only when a swap file is found
autocmd vimrc SwapExists * let v:swapchoice = 'o'

" Automatically set expandtab
autocmd vimrc FileType * execute 'setlocal ' . (search('^\t.*\n\t.*\n\t', 'n') ? 'no' : '') . 'expandtab'

" Set nonumber in terminal window
autocmd vimrc BufWinEnter * if &l:buftype == 'terminal' | setlocal nonumber | endif

" Setting lazyredraw causes a problem on startup
autocmd vimrc VimEnter * redraw

autocmd FileType clojure RainbowParentheses

augroup NumberToggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * :set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * :set norelativenumber
augroup end

try
  colorscheme OceanicNext
catch
  colorscheme afterglow
endtry

let g:signify_sign_delete = '-'
au! BufNewFile,BufRead *.boot setf clojure

hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE
hi! LineNr ctermfg=NONE guibg=NONE
hi! SignColumn ctermfg=NONE guibg=NONE
hi! StatusLine guifg=#16252b guibg=#6699CC
hi! StatusLineNC guifg=#16252b guibg=#16252b

hi! VertSplit gui=NONE guifg=#17252c guibg=#17252c

" Make background color transparent for git changes
hi! SignifySignAdd guibg=NONE
hi! SignifySignDelete guibg=NONE
hi! SignifySignChange guibg=NONE

" Highlight git change signs
hi! SignifySignAdd guifg=#99c794
hi! SignifySignDelete guifg=#ec5f67
hi! SignifySignChange guifg=#c594c5

autocmd FileType python,javascript autocmd BufWritePre <buffer> %s/\s\+$//e

" Reload icons after init source
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

" Plugin: lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'readonly': 'LightlineReadonly',
      \ },
      \ }

function! LightlineReadonly()
  return &readonly && &filetype !=# 'help' ? 'RO' : ''
endfunction

" Plugin: vim-go
let g:go_fmt_command = "goimports"
let g:go_info_mode = "gopls"
let g:go_auto_type_info = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 0

" Plugin: python-mode
let g:pymode_python = 'python3'
let g:pymode_indent = 1
let g:pymode_doc = 1
let g:pymode_lint_on_write = 1

" Plugin: echodoc
" Or, you could use neovim's floating text feature.
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'virtual'
" To use a custom highlight for the float window,
" change Pmenu to your highlight group
highlight link EchoDocFloat Pmenu

if filereadable(expand('$XDG_CONFIG_HOME/nvim/mappings.vim'))
  source ~/.config/nvim/mappings.vim
endif

" lua require('aniseed.dotfiles')