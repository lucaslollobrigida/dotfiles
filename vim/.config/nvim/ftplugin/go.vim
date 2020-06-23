if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

setlocal comments=s1:/*,mb:*,ex:*/,://
setlocal commentstring=//\ %s

source $HOME/.config/nvim/common/eightspaceindent.vim

" use omni completion provided by lsp
" setlocal omnifunc=v:lua.vim.lsp.omnifunc
" autocmd CursorHold <buffer> lua vim.lsp.util.show_line_diagnostics()

compiler go

let g:projectionist_heuristics = {
      \  "go.mod": {
      \    "*.go": {
      \      "type": "source",
      \      "alternate": "{}_test.go",
      \      "template": [
      \        "package {dirname}"
      \      ]
      \    },
      \    "*_test.go": {
      \      "type": "test",
      \      "alternate": "{}.go",
      \      "template": [
      \        "package {dirname}",
      \      ],
      \    }
      \  }
      \}

" LSP
" nnoremap <silent> <buffer> gd        <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> <buffer> [d        :echom "[LSP] gols doesn't support declarations()."<CR>
" nnoremap <silent> <buffer> K         <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> <buffer> gD        <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> <buffer> gi	       <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <buffer> gs	       <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> <buffer> gt	       <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> <buffer> gW	       <cmd>lua vim.lsp.buf.document_symbol()<CR>
" nnoremap <silent> <buffer> gt	       <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" nnoremap <silent> <buffer> <leader>r <cmd>lua vim.lsp.buf.rename()<CR>
