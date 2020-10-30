" Plugin: conjure
" augroup ConjureLog
"   autocmd!
"   autocmd BufEnter conjure-log-* AnsiEsc!
" augroup END

let g:conjure#log#strip_ansi_escape_sequences_line_limit = 0

" let g:conjure#mapping#eval_root_form = "ed"
" let g:conjure#client#clojure#nrepl#mapping#eval_root_form = "ed"

let g:conjure#client#clojure#nrepl#mapping#connect_port_file = "'"
let g:conjure#client#clojure#nrepl#mapping#disconnect = "rq"
let g:conjure#client#clojure#nrepl#mapping#interrupt = "ri"
let g:conjure#client#clojure#nrepl#mapping#last_exception = "re"
let g:conjure#client#clojure#nrepl#mapping#run_current_ns_tests = "tn"
let g:conjure#client#clojure#nrepl#mapping#run_current_test = "tt"
let g:conjure#client#clojure#nrepl#mapping#run_alternate_ns_tests = "tN"

" use <local leader> K to get docstring trough REPL connection
let g:conjure#mapping#doc_word = "K"

" use gd to jump to definition trough REPL connection
let g:conjure#mapping#def_word = "gd"

" Plugin: auto-pairs
let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"'}

" Plugin: vim-sexp-mappings-for-regular-people
let g:sexp_no_word_maps = 1
