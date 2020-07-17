" Note: Disabled Builting LSP for now
" if LSPEnable()
"   try
"     luafile $HOME/.config/nvim/lua/init.lua
"   endtry
" end

" Plugin: nvim-diagnostics
" let g:diagnostic_enable_virtual_text = 0
" let g:diagnostic_show_sign = 1
" let g:diagnostic_auto_popup_while_jump = 1
" let g:diagnostic_insert_delay = 1

" call sign_define("LspDiagnosticsErrorSign", {"text" : ">>", "texthl" : "LspDiagnosticsError"})
" call sign_define("LspDiagnosticsWarningSign", {"text" : "⚡", "texthl" : "LspDiagnosticsWarning"})
" call sign_define("LspDiagnosticsInformationSign", {"text" : "", "texthl" : "LspDiagnosticsInformation"})
" call sign_define("LspDiagnosticsHintSign", {"text" : "", "texthl" : "LspDiagnosticsWarning"})

" " Plugin: nvim-completion
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

" let g:completion_enable_auto_popup = 1
" let g:completion_auto_change_source = 1
" let g:completion_enable_auto_paren = 1
" let g:completion_trigger_keyword_length = 2
" " let g:completion_timer_cycle = 200
" " let g:completion_max_items = 10
" let g:completion_enable_snippet = 'UltiSnips'
" let g:completion_confirm_key = "\<CR>"

" let g:completion_chain_complete_list = {
"   \  'default': [
"   \     {'complete_items': ['lsp', 'snippet']},
"   \     {'mode': '<c-p>'},
"   \     {'mode': '<c-n>'},
"   \  ],
"   \  'c': [
"   \     {'complete_items': ['lsp', 'snippet']},
"   \     {'mode': 'tags'},
"   \     {'mode': '<c-p>'},
"   \     {'mode': '<c-n>'},
"   \  ],
"   \}

" Plugin: coc.nvim
nnoremap <silent> gd          <Plug>(coc-definition)
nnoremap <silent> [d          <Plug>(coc-declarations)
nnoremap <silent> K           :call ShowDocumentation()<CR>
nnoremap <silent> gD          <Plug>(coc-references)
nnoremap <silent> gi          <Plug>(coc-implementation)
nnoremap <silent> gt          <Plug>(coc-type-definition)
nnoremap <silent> <leader>r   <Plug>(coc-rename)

imap <C-y> <Plug>(coc-snippets-expand)
vmap <C-y> <Plug>(coc-snippets-select)
imap <C-y> <Plug>(coc-snippets-expand-jump)

let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'

xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Autoorganize imports on save
  autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help'
      \]

let g:coc_global_extensions = [
      \ 'coc-clangd',
      \ 'coc-conjure',
      \ 'coc-elixir',
      \ 'coc-go',
      \ 'coc-json',
      \ 'coc-rust-analyzer',
      \ 'coc-snippets',
      \ 'coc-tsserver',
      \ ]
