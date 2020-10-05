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
Plug 'itchyny/lightline.vim'
Plug 'sainnhe/sonokai'
Plug 'mhinz/vim-signify'
Plug 'ryanoasis/vim-devicons'
Plug 'ncm2/float-preview.nvim'
Plug 'norcalli/nvim-terminal.lua'
Plug 'tjdevries/cyclist.vim'

" Focus mode
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Editing
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-surround'
Plug 'guns/vim-sexp' | Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release', 'for': 'clojure'}
" Plug 'bhurlow/vim-parinfer'
" Plug 'jiangmiao/auto-pairs'

" Project
Plug 'justinmk/vim-dirvish'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-dispatch' | Plug 'radenling/vim-dispatch-neovim'
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
Plug 'm00qek/nvim-contabs'
Plug 'tpope/vim-fugitive'
Plug 'voldikss/vim-floaterm'

" REPL integration
Plug 'clojure-vim/vim-jack-in', {'for': 'clojure'}
Plug 'Olical/conjure' | Plug 'Olical/AnsiEsc'

" LSP Engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" Syntax
Plug 'guns/vim-clojure-highlight'
Plug 'guns/vim-clojure-static'
Plug 'dart-lang/dart-vim-plugin'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'LnL7/vim-nix'

" Snippets
Plug 'SirVer/ultisnips'

" Notetaking
Plug 'ihsanturk/neuron.vim'

call plug#end()

" Plugin: coc.nvim
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [d <Plug>(coc-declarations)
nmap <silent> gW :<C-u>CocList -I symbols<cr>

nnoremap <leader>rn <Plug>(coc-rename)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

nnoremap <silent> K :call ShowDocumentation()<CR>

" code action
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>aa  <Plug>(coc-codeaction)
nmap <leader>aq  <Plug>(coc-fix-current)

nmap <silent> <leader>d  :<C-u>CocList diagnostics<cr>

let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'

xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction

" Plugin: Lightline
let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'fugitive', 'cocerror', 'cocwarn', 'readonly', 'filename', 'modified' ] ],
  \   'right': [ [ 'lineinfo' ],
  \            [ 'percent' ],
  \            [ 'ff_icon', 'ft_icon' ] ] },
  \ 'inactive': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
  \   'right': [ [ 'lineinfo' ],
  \            [ 'percent' ],
  \            [ 'ff_icon', 'ft_icon' ] ] },
  \ 'component': {
  \   'lineinfo': ' %3l:%-2v',
  \ },
  \ 'component_function': {
  \   'readonly': 'LightlineReadonly',
  \   'fugitive': 'LightlineFugitive',
  \   'ft_icon': 'FileTypeWithIcon',
  \   'ff_icon': 'FileFormatWithIcon',
  \ },
  \ 'component_expand': {
  \   'cocerror': 'LightLineCocError',
  \   'cocwarn' : 'LightLineCocWarn',
  \ },
  \ 'component_type': {
  \   'cocerror': 'error',
  \   'cocwarn' : 'warning',
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' }
  \ }

function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction

function! LightlineFugitive()
  if exists('*FugitiveHead')
    let branch = FugitiveHead()
    return branch !=# '' ? ''.branch : ''
  endif
  return ''
endfunction

function! FileTypeWithIcon() abort
  let filetype_with_icon = &filetype !=# '' ? &filetype : 'no ft'
  return winwidth(0) > 70 ? WebDevIconsGetFileTypeSymbol() . ' ' . &filetype : ' '
endfunction

function! FileFormatWithIcon() abort
  let fileformat_with_icon = &fileformat !=# '' ? &fileformat : 'no ff'
  return winwidth(0) > 70 ? WebDevIconsGetFileFormatSymbol() . ' ' . &fileformat : ' '
endfunction

function! LightLineCocError()
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info)
    return ''
  endif

  let errmsgs = []

  if get(info, 'error', 0)
    let s:error_sign = get(g:, 'coc_status_error_sign', '✘ ')
    call add(errmsgs, s:error_sign . info['error'])
  endif

  return trim(join(errmsgs, ' ') . ' ' . get(g:, 'coc_status', ''))
endfunction

function! LightLineCocWarn() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info)
    return ''
  endif

  let warnmsgs = []

  if get(info, 'warning', 0)
    let s:warning_sign = get(g:, 'coc_status_warning_sign', ' ')
    call add(warnmsgs, s:warning_sign . info['warning'])
  endif

  return trim(join(warnmsgs, ' ') . ' ' . get(g:, 'coc_status', ''))
endfunction

autocmd User CocDiagnosticChange call lightline#update()

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType clojure,typescript,json setl formatexpr=CocAction('formatSelected')
  " Autoorganize imports on save
  autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  " highlight symbol under cursor
  autocmd CursorHold  * silent call CocActionAsync('highlight')
  autocmd CursorHoldI * silent call CocActionAsync('highlight')
augroup end

let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help'
      \]

let g:coc_global_extensions = [
      \ 'coc-clangd',
      \ 'coc-conjure',
      \ 'coc-elixir',
      \ 'coc-flutter',
      \ 'coc-go',
      \ 'coc-highlight',
      \ 'coc-json',
      \ 'coc-rust-analyzer',
      \ 'coc-snippets',
      \ 'coc-tsserver',
      \ 'coc-vimlsp',
      \ ]

autocmd BufReadCmd,FileReadCmd,SourceCmd jar:file://* call s:LoadClojureContent(expand("<amatch>"))

 function! s:LoadClojureContent(uri)
  setfiletype clojure
  let content = CocRequest('clojure-lsp', 'clojure/dependencyContents', {'uri': a:uri})
  call setline(1, split(content, "\n"))
  setl nomodified
  setl readonly
endfunction

let g:clojure_fuzzy_indent_patterns = ['^doto', '^with', '^def', '^let', 'go-loop', 'match', '^context', '^GET', '^PUT', '^POST', '^PATCH', '^DELETE', '^ANY', 'this-as', '^are', '^dofor']

let g:clojure_syntax_keywords = {
    \ 'clojureDefine': ["defproject", "defcustom", "s/defn", "s/defmethod", "s/def", "s/defrecord", "s/defschema", "deftest", "defresolver", "defmutation"],
    \ 'clojureMacro': ["s/with-fn-validation", "with-system"],
    \ 'clojureFunc': ["are", "is", "testing", "match?",  "match"]
    \ }

command! -nargs=0 Format :call CocAction('format')

" Test
nnoremap <silent> crcc :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'cycle-coll', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crth :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-first', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crtt :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-last', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crtf :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-first-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crtl :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-last-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cruw :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'unwind-thread', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crua :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'unwind-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crml :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'move-to-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Binding name: ')]})<CR>
nnoremap <silent> cril :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'introduce-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Binding name: ')]})<CR>
nnoremap <silent> crel :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'expand-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cram :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'add-missing-libspec', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crcn :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'clean-ns', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crcp :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'cycle-privacy', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cris :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'inline-symbol', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cref :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'extract-function', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Function name: ')]})<CR>
