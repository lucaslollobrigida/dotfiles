if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

source $HOME/.config/nvim/common/twospaceindent.vim

setlocal
      \ comments=n:;
      \ commentstring=;;\ %s
      \ iskeyword+=-,+,*,?,!,>,<,',#,/,:,.
      " \ lisp

let b:clojure_syntax_keywords = {
    \ 'clojureMacro': [
    \   "is", "deftest", "testing", "match?",
    \   "s/defn", "s/defmethod", "s/defprotocol", "s/defschema", "s/defrecord"],
    \ }

let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"'}

nnoremap <buffer> cpb :%CljEval<CR>
nnoremap <buffer> cpf :exe "normal! vaF":<c-u>CljEval<CR>
nnoremap <buffer> cpl :Require<CR>
nnoremap <buffer> gd  :Djump <C-R>=expand("<cword>")<CR><CR>
