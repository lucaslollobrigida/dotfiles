if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

setlocal autoindent
setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2
setlocal comments=n:;
setlocal commentstring=;;\ %s
setlocal iskeyword+=-,+,*,?,!,>,<,',#,/,:,.

" Clojure
" let g:clojure_fuzzy_indent = 1
" let g:clojure_align_multiline_strings = 1
" let g:clojure_align_subforms = 1
" let g:clojure_fuzzy_indent_patterns = 
"   \ ['ns', '^doto', '^with', '^def', '^let', '^if', '^when', '^cond', 'flow', 'testing', '^context', '^GET', '^PUT', '^POST', '^PATCH', '^DELETE', '^ANY', '^are']

" let g:clojure_fuzzy_indent_blacklist = []

" let g:clojure_syntax_keywords = {
"     \ 'clojureDefine': ["defflow", "defproject", "defcustom", "s/defn", "s/defmethod", "s/def", "s/defrecord", "s/defschema", "deftest", "defspec", "defresolver", "defmutation"],
"     \ 'clojureMacro': ["s/with-fn-validation", "with-system", "flow"],
"     \ 'clojureFunc': ["are", "is", "testing", "match?",  "match"]
"     \ }

let g:projectionist_heuristics = {
      \  "deps.edn|project.clj": {
      \    "*": {"dispatch": "clj -A:test", "make": "clj -A:uberjar", "start": "clj -A:run"},
      \    "src/*.clj": {
      \      "type": "source",
      \      "alternate": "test/unit/{}_test.clj",
      \      "template": [
      \        "(ns {dot|hyphenate})"
      \      ]
      \    },
      \    "test/unit/*_test.clj": {
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
