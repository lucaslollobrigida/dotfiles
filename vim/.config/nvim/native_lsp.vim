lua require('plugins')

packloadall

" This disables the fairly slow loading of server installation commands, which we don't really use
" anyway
let g:nvim_lsp = 1

set omnifunc=v:lua.vim.lsp.omnifunc
" autocmd CursorHold lua vim.lsp.util.show_line_diagnostics()

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

let g:completion_customize_lsp_label = {
      \ 'Function': ' [function]',
      \ 'Method': ' [method]',
      \ 'Reference': ' [refrence]',
      \ 'Enum': ' [enum]',
      \ 'Field': 'ﰠ [field]',
      \ 'Keyword': ' [key]',
      \ 'Variable': ' [variable]',
      \ 'Folder': ' [folder]',
      \ 'Snippet': ' [snippet]',
      \ 'Operator': ' [operator]',
      \ 'Module': ' [module]',
      \ 'Text': 'ﮜ[text]',
      \ 'Class': ' [class]',
      \ 'Interface': ' [interface]'
      \}

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

lua require('lsp')
