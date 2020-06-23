if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

source $HOME/.config/nvim/common/twospaceindent.vim

setlocal
      \ comments=n:;
      \ commentstring=;;\ %s
      \ iskeyword+=-,+,*,?,!,>,<,',#,/,:,.

let b:clojure_syntax_keywords = {
    \ 'clojureMacro': [
    \   "is", "deftest", "testing", "match?",
    \   "s/defn", "s/defmethod", "s/defprotocol", "s/defschema", "s/defrecord"],
    \ }

let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"'}

" autocmd BufWrite :call TrimWS()<CR>

let g:projectionist_heuristics = {
      \  "deps.edn|project.clj": {
      \    "*": {"dispatch": "clj -A:test", "make": "clj -A:jar", "start": "clj -A:run"},
      \    "src/*.clj": {
      \      "type": "source",
      \      "alternate": "test/{}_test.clj",
      \      "template": [
      \        "(ns {dot|hyphenate})"
      \      ]
      \    },
      \    "test/*_test.clj": {
      \      "type": "test",
      \      "alternate": "src/{}.clj",
      \      "template": [
      \        "(ns {dot|hyphenate}-test",
      \        "  (:require [clojure.test :refer [deftest testing is]]",
      \        "            [{dot|hyphenate} :as {dot|hyphenate}]))",
      \      ],
      \    }
      \  }
      \}

nnoremap <buffer> <localleader>rs :Dispatch! clj -A:repl<CR>

" LSP
" autocmd <buffer> BufEnter * lua require'completion'.on_attach()
" autocmd <buffer> BufEnter * lua require'completion'.addCompletionSource('conjure', ConjureOmnifunc)

" nnoremap <silent> <buffer> gd        <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> <buffer> [d        <cmd>lua vim.lsp.buf.declarations()<CR>
" nnoremap <silent> <buffer> K         <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> <buffer> gD        <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> <buffer> gi	       <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <buffer> gs	       <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> <buffer> gt	       <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> <buffer> gW	       <cmd>lua vim.lsp.buf.document_symbol()<CR>
" nnoremap <silent> <buffer> gt	       <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" nnoremap <silent> <buffer> <leader>r <cmd>lua vim.lsp.buf.rename()<CR>
