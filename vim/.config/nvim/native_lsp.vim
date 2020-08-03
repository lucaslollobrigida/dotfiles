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

" This disables the fairly slow loading of server installation commands, which we don't really use
" anyway
let g:nvim_lsp = 1

set omnifunc=v:lua.vim.lsp.omnifunc
" autocmd CursorHold lua vim.lsp.util.show_line_diagnostics()

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" Plugin: nvim-diagnostics
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_show_sign = 1
let g:diagnostic_auto_popup_while_jump = 1
let g:diagnostic_insert_delay = 1

call sign_define("LspDiagnosticsErrorSign", {"text" : "✘", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "⚡", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsInformationSign", {"text" : "", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsHintSign", {"text" : "", "texthl" : "LspDiagnosticsWarning"})
call sign_define('LspDiagnosticsErrorSign', {'text' : '🗙', 'texthl' : 'RedHover'})
call sign_define('LspDiagnosticsWarningSign', {'text' : '➤', 'texthl' : 'YellowHover'})
call sign_define('LspDiagnosticsInformationSign', {'text' : '🛈', 'texthl' : 'WhiteHover'})
call sign_define('LspDiagnosticsHintSign', {'text' : '❗', 'texthl' : 'CocHintHighlight'})

" Plugin: vim-vsnip
let g:vsnip_snippet_dir = "~/.config/nvim/vsnip"
let g:completion_enable_snippet = 'vim-vsnip'
" imap <expr> <C-y> <Plug>(completion_confirm_completion)
imap <expr> <C-y> pumvisible() ? (vsnip#available(1) ? '<Plug>(vsnip-expand)' : '<Plug>(completion_confirm_completion)') : "\<C-y>"
imap <expr> <C-j> vsnip#available(1) ? '<Plug>(vsnip-jump-next)' : "\<C-j>"
smap <expr> <C-j> vsnip#available(1) ? '<Plug>(vsnip-jump-next)' : "\<C-j>"
imap <expr> <C-k> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : "\<C-k>"
smap <expr> <C-k> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : "\<C-k>"

" Plugin: nvim-completion
let g:completion_trigger_on_delete = 1
let g:completion_auto_change_source = 1
let g:completion_enable_auto_popup = 1
let g:completion_max_items = 30
let g:completion_confirm_key = ''

" inoremap <silent> <Plug>(ComplCREnd) <cr>
" imap <silent><expr> <Plug>ComplCR pumvisible() ? complete_info()['selected'] != -1 ? "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>" :  "\<Plug>(ComplCREnd)"
" imap <silent><cr> <Plug>ComplCR<Plug>CloserClose<Plug>DiscretionaryEnd
" let g:completion_customize_lsp_label = {
"       \ 'Function': ' [function]',
"       \ 'Method': ' [method]',
"       \ 'Reference': ' [refrence]',
"       \ 'Enum': ' [enum]',
"       \ 'Field': 'ﰠ [field]',
"       \ 'Keyword': ' [key]',
"       \ 'Variable': ' [variable]',
"       \ 'Folder': ' [folder]',
"       \ 'Snippet': ' [snippet]',
"       \ 'Operator': ' [operator]',
"       \ 'Module': ' [module]',
"       \ 'Text': 'ﮜ[text]',
"       \ 'Class': ' [class]',
"       \ 'Interface': ' [interface]'
"       \}

let g:completion_chain_complete_list = {
      \ 'clojure': {
      \   'default': [
      \     {'complete_items': ['conjure', 'lsp', 'snippet']},
      \   ],
      \ },
      \ 'default' : {
      \   'default': [
      \     {'complete_items': ['lsp']},
      \     {'mode': '<c-p>'},
      \     {'mode': '<c-n>'},
      \   ],
      \   'comment': [],
      \   'string' : [
      \       {'complete_items': ['path'], 'triggered_only': ['/']}]
      \ },
      \ 'tex': {
      \     'default': [
      \     { 'complete_items': ['lsp'] },
      \     { 'complete_items': ['vimtex'] },
      \     { 'mode': '<c-p>' },
      \     { 'mode': '<c-n>' },
      \     ],
      \     'comment': [],
      \     'string' : [ {'complete_items': ['path']} ]
      \ },
      \ 'markdown': {
      \     'default': [
      \     { 'complete_items': ['wiki'] },
      \     { 'mode': '<c-p>' },
      \     { 'mode': '<c-n>' },
      \]
      \},
      \ 'lisp': {
      \     'default': [
      \     { 'complete_items': ['vlime'] },
      \     { 'mode': '<c-p>' },
      \     { 'mode': '<c-n>' },
      \],
      \     'comment': [],
      \     'string' : [ {'complete_items': ['path']} ]
      \}
      \}

let g:completion_customize_lsp_label = {
      \ 'Function': "\uf794",
      \ 'Method': "\uf6a6",
      \ 'Variable': "\uf71b",
      \ 'Constant': "\uf8ff",
      \ 'Struct': "\ufb44",
      \ 'Class': "\uf0e8",
      \ 'Interface': "\ufa52",
      \ 'Text': "\ue612",
      \ 'Enum': "\uf435",
      \ 'EnumMember': "\uf02b",
      \ 'Module': "\uf668",
      \ 'Color': "\ue22b",
      \ 'Property': "\ufab6",
      \ 'Field': "\uf93d",
      \ 'Unit': "\uf475",
      \ 'File': "\uf471",
      \ 'Value': "\uf8a3",
      \ 'Event': "\ufacd",
      \ 'Folder': "\uf115",
      \ 'Keyword': "\uf893",
      \ 'Snippet': "\uf64d",
      \ 'Operator': "\uf915",
      \ 'Reference': "\uf87a",
      \ 'TypeParameter': "\uf278",
      \ 'Default': "\uf29c"
      \}

let g:vsnip_integ_config = {
      \ 'vim_lsp': v:false,
      \ 'vim_lsc': v:false,
      \ 'lamp': v:false,
      \ 'deoplete_lsp': v:false,
      \ 'nvim_lsp': v:true,
      \ 'language_client_neovim': v:false,
      \ 'asyncomplete': v:false,
      \ 'deoplete': v:false,
      \ 'mucomplete': v:false,
      \ 'compete': v:false,
      \}

lua lsp = require('lsp')
