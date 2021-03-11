if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

setlocal shiftwidth=2
setlocal tabstop=2
setlocal comments=s1:/*,mb:*,ex:*/,://
setlocal commentstring=//\ %s

let g:projectionist_heuristics = {
      \  "pubspec.yaml": {
      \    "lib/*.dart": {
      \      "type": "source",
      \      "alternate": "test/{}_test.dart",
      \    },
      \    "test/*_test.dart": {
      \      "type": "test",
      \      "alternate": "lib/{}.dart",
      \    }
      \  }
      \}
