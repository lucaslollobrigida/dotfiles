" Plugin: conjure
autocmd BufEnter conjure-log-* AnsiEsc

let g:conjure_config = {
      \ "mappings.eval-root-form": "ed",
      \ "clojure.nrepl/mappings.disconnect": "rq",
      \ "clojure.nrepl/mappings.connect-port-file": "'",
      \ "clojure.nrepl/mappings.interrupt": "ri",
      \ "clojure.nrepl/mappings.last-exception": "re",
      \ "clojure.nrepl/mappings.run-current-ns-tests": "tn",
      \ "clojure.nrepl/mappings.run-current-test": "tt",
      \ "clojure.nrepl/mappings.run-alternate-ns-tests": "tN",
      \ "log.hud.enabled?": v:true,
      \ "log.botright?": v:true,
      \ "log.strip-ansi-escape-sequences-line-limit": 0
      \ }

" `clojure.nrepl/connection.port-files`
"             List of file paths to check when starting up or hitting
"             `<localleader>cf` (by default). They're checked in order, the
"             first file to exist has it's contents parsed as a number.
"             Conjure will then connect to that port at the host specified by
"             `connection.default-host`.
"             Conjure checks every directory above your current one as well as
"             `~/.config/conjure`, so you can place a default `.nrepl-port`
"             file in there to always have a default port to attempt.
"             Default: `[".nrepl-port" ".shadow-cljs/nrepl.port"]`

" `clojure.nrepl/refresh.after`
"             The namespace-qualified name of a zero-arity function to call
"             after reloading.
"             Default: `nil`

" `clojure.nrepl/refresh.before`
"             The namespace-qualified name of a zero-arity function to call
"             before reloading.
"             Default: `nil`

" `clojure.nrepl/mappings.view-source`
"             View the source of the symbol under the cursor.
"             Default: `vs`
