" Plugin: nvim-diagnostics
let g:diagnostic_enable_virtual_text = 0
let g:diagnostic_show_sign = 1
let g:diagnostic_auto_popup_while_jump = 1
let g:diagnostic_insert_delay = 1

call sign_define("LspDiagnosticsErrorSign", {"text" : ">>", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "⚡", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsInformationSign", {"text" : "", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsHintSign", {"text" : "", "texthl" : "LspDiagnosticsWarning"})

" Plugin: nvim-completion
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

let g:completion_enable_auto_popup = 1
let g:completion_auto_change_source = 1
let g:completion_enable_auto_paren = 1
let g:completion_trigger_keyword_length = 2
" let g:completion_timer_cycle = 200
" let g:completion_max_items = 10
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_confirm_key = "\<CR>"
" imap <expr> <c-y>  pumvisible() ? complete_info()["selected"] != "-1" ?
"                  \ "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<c-y>" :  "\<c-y>"

let g:UltiSnipsExpandTrigger="<c-y>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

let g:completion_chain_complete_list = {
  \  'default': [
  \     {'complete_items': ['lsp', 'snippet']},
  \     {'mode': '<c-p>'},
  \     {'mode': '<c-n>'},
  \  ],
  \  'clojure': [
  \     {'mode': '<c-o>'},
  \     {'complete_items': ['lsp', 'snippet']},
  \     {'mode': '<c-n>'},
  \  ],
  \  'c': [
  \     {'complete_items': ['lsp', 'snippet']},
  \     {'mode': 'tags'},
  \     {'mode': '<c-p>'},
  \     {'mode': '<c-n>'},
  \  ],
  \}
