" Plugin: projectionist.vim
" let g:projectionist_heuristics = {
"       \  "*.sh": {
"       \     "template": ["#!/usr/bin/env bash"],
"       \  }
"       \}


      " \ "src/**/*.clj": {
      " \   "alternate": "test/**/{}_test.clj",
      " \   "type": "source"
      " \ },
      " \ "test/**/*.clj": {
      " \   "alternate": "src/**/{}.clj",
      " \   "type": "test"
      " \ },
      " \ "src/main/java/**/*.java": {
      " \   "alternate": "src/test/java/AppTest.java",
      " \   "type": "source"
      " \ },
      " \ "src/test/java/*.java": {
      " \   "alternate": "src/main/java/{}.java",
      " \   "type": "test"
      " \ },
      " \ "*.java": {
      " \   "dispatch": "javac {file}",
      " \   "make": "mvn"
      " \ }
