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
Plug 'tpope/vim-surround'
Plug 'guns/vim-sexp' | Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'jiangmiao/auto-pairs'

" Project
Plug 'justinmk/vim-dirvish'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-dispatch' | Plug 'radenling/vim-dispatch-neovim'
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
Plug 'm00qek/nvim-contabs'
Plug 'tpope/vim-fugitive'
Plug 'voldikss/vim-floaterm'

" REPL integration
Plug 'clojure-vim/vim-jack-in'
Plug 'Olical/conjure' | Plug 'Olical/AnsiEsc'

" LSP Engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" Syntax
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
nnoremap <silent> gd          <Plug>(coc-definition)
nnoremap <silent> [d          <Plug>(coc-declarations)
nnoremap <silent> K           :call ShowDocumentation()<CR>
nnoremap <silent> gD          <Plug>(coc-type-definition)
nnoremap <silent> gr          <Plug>(coc-references)
nnoremap <silent> gi          <Plug>(coc-implementation)
nnoremap <silent> gW  :<C-u>CocList -I symbols<cr>

nnoremap <leader>rn <Plug>(coc-rename)
xnoremap <leader>f  <Plug>(coc-format-selected)
nnoremap <leader>f  <Plug>(coc-format-selected)

" code action
vnoremap <leader>a  <Plug>(coc-codeaction-selected)
nnoremap <leader>a  <Plug>(coc-codeaction-selected)
nnoremap <leader>aa  <Plug>(coc-codeaction)
nnoremap <leader>aq  <Plug>(coc-fix-current)

nnoremap <silent> <leader>d  :<C-u>CocList diagnostics<cr>

let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'

xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction

" Plugin: Lightline
" let g:lightline = {
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
"       \ },
"       \ 'component_function': {
"       \   'gitbranch': 'FugitiveHead'
"       \ },
"       \ }
   let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
    \ 'right': [ [ 'lineinfo' ],
    \            [ 'percent' ],
    \            [ 'ff_icon', 'fileencoding', 'ft_icon' ] ] },
    \ 'inactive': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
    \ 'right': [ [ 'lineinfo' ],
    \            [ 'percent' ],
    \            [ 'ff_icon', 'fileencoding', 'ft_icon' ] ] },
    \ 'component': {
    \   'lineinfo': ' %3l:%-2v',
    \ },
    \ 'component_function': {
    \   'readonly': 'LightlineReadonly',
    \   'fugitive': 'LightlineFugitive',
    \   'ft_icon': 'FileTypeWithIcon',
    \   'ff_icon': 'FileFormatWithIcon',
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
  let modified = &modified ? '  ' : ''
  return winwidth(0) > 70 ? WebDevIconsGetFileTypeSymbol() . ' ' . modified . &filetype : ' '
endfunction

function! FileFormatWithIcon() abort
  let fileformat_with_icon = &fileformat !=# '' ? &fileformat : 'no ff'
  let modified = &modified ? '  ' : ''
  return winwidth(0) > 70 ? WebDevIconsGetFileFormatSymbol() . ' ' . modified . &fileformat : ' '
endfunction

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Autoorganize imports on save
  autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  " highlight symbol under cursor
  " autocmd CursorHold  * silent call CocActionAsync('highlight')
  " autocmd CursorHoldI * silent call CocActionAsync('highlight')
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

nmap <silent> crcc :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'cycle-coll', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nmap <silent> crth :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-first', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nmap <silent> crtt :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-last', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nmap <silent> crtf :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-first-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nmap <silent> crtl :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-last-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nmap <silent> cruw :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'unwind-thread', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nmap <silent> crua :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'unwind-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nmap <silent> crml :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'move-to-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Binding name: ')]})<CR>
nmap <silent> cril :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'introduce-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Binding name: ')]})<CR>
nmap <silent> crel :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'expand-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nmap <silent> cram :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'add-missing-libspec', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nmap <silent> crcn :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'clean-ns', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nmap <silent> crcp :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'cycle-privacy', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nmap <silent> cris :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'inline-symbol', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nmap <silent> cref :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'extract-function', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Function name: ')]})<CR>
