Packadd [[conjure]]

-- Plugin: conjure
-- augroup ConjureLog
--   autocmd!
--   autocmd BufEnter conjure-log-* AnsiEsc!
-- augroup END

vim.g['conjure#log#strip_ansi_escape_sequences_line_limit'] = 0
vim.g['conjure#client#clojure#nrepl#test#current_form_names'] = {"deftest", "defflow", "defspec"}

vim.g['conjure#mapping#doc_word'] = 'K'
vim.g['conjure#client#clojure#nrepl#mapping#run_current_test'] = 'tt'
