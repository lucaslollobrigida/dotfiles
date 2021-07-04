vim.api.nvim_set_var("sexp_filetypes", "clojure,racket,scheme,lisp,fennel")
vim.api.nvim_set_var("sexp_no_word_maps", true)

vim.api.nvim_exec(
  [[
augroup ConjureLog
  autocmd!
  setlocal scrolloff=0
augroup END
]],
  false
)

vim.g["conjure#log#strip_ansi_escape_sequences_line_limit"] = 0

vim.g["conjure#log#fold#enabled"] = true
vim.g["conjure#log#wrap"] = true
vim.g["conjure#client#clojure#nrepl#test#current_form_names"] = { "deftest", "defflow", "defspec" }

vim.g["conjure#mapping#doc_word"] = "K"
vim.g["conjure#client#clojure#nrepl#mapping#run_current_test"] = "tt"
