" Clojure
let g:clojure_fuzzy_indent = 1
let g:clojure_align_multiline_strings = 1
let g:clojure_align_subforms = 1
let g:clojure_fuzzy_indent_patterns = 
  \ ['^doto', '^with', '^def', '^let', '^cond', 'flow', 'testing', '^context', '^GET', '^PUT', '^POST', '^PATCH', '^DELETE', '^ANY', '^are']

let g:clojure_fuzzy_indent_blacklist = []

let g:clojure_syntax_keywords = {
    \ 'clojureDefine': ["defflow", "defproject", "defcustom", "s/defn", "s/defmethod", "s/def", "s/defrecord", "s/defschema", "deftest", "defspec", "defresolver", "defmutation"],
    \ 'clojureMacro': ["s/with-fn-validation", "with-system", "flow"],
    \ 'clojureFunc': ["are", "is", "testing", "match?",  "match"]
    \ }
