if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

setlocal expandtab
setlocal smartindent
setlocal shiftwidth=2
setlocal tabstop=2
setlocal comments=n:;
setlocal commentstring=;;\ %s
setlocal iskeyword+=-,+,*,?,!,>,<,',#,/,:,.

let g:projectionist_heuristics = {
      \  "deps.edn|project.clj": {
      \    "*": {"dispatch": "clj -A:test", "make": "clj -A:jar", "start": "clj -A:run"},
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
