if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

setlocal expandtab
setlocal smartindent
setlocal shiftwidth=8
setlocal tabstop=8
setlocal comments=s1:/*,mb:*,ex:*/,://
setlocal commentstring=//\ %s

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
