local has_sexp = pcall(vim.cmd, [[packadd vim-sexp]])
if not has_sexp then
  print('[Lisp] vim-sexp is required for this package.')
  return
end

require('lollo.lisp.conjure')

--  Plugin: vim-sexp
vim.api.nvim_set_var('sexp_filetypes', 'clojure,racket,scheme,lisp,fennel')
vim.api.nvim_set_var('sexp_no_word_maps', true)
