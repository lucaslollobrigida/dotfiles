" Plugin: conjure
autocmd BufEnter conjure-log-* AnsiEsc

let g:conjure#mapping#eval_root_form = "ed"
let g:conjure#client#clojure#nrepl#mapping#disconnect = "rq"
let g:conjure#client#clojure#nrepl#mapping#connect_port_file = "'"
let g:conjure#client#clojure#nrepl#mapping#interrupt = "ri"
let g:conjure#client#clojure#nrepl#mapping#last_exception = "re"
let g:conjure#client#clojure#nrepl#mapping#run_current_ns_tests = "tn"
let g:conjure#client#clojure#nrepl#mapping#run_current_test = "tt"
let g:conjure#client#clojure#nrepl#mapping#run_alternate_ns_tests = "tN"

let g:conjure#log#hud#enabled = v:true
let g:conjure#log#botright = v:true
let g:conjure#log#strip_ansi_escape_sequences_line_limit = 0
