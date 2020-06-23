if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

setlocal comments=s1:/*,mb:*,ex:*/,://
setlocal commentstring=//\ %s

source $HOME/.config/nvim/common/fourspaceindent.vim

" use omni completion provided by lsp
" setlocal omnifunc=v:lua.vim.lsp.omnifunc
" autocmd CursorHold <buffer> lua vim.lsp.util.show_line_diagnostics()

compiler javac

let g:projectionist_heuristics = {
      \  "build.gradle*&settings.gradle*|pom.xml": {
      \    "*.java": {"dispatch": "javac {file}"},
      \    "*": {"make": "mvn compile"},
      \    "src/main/java/*.java": {
      \      "type": "source",
      \      "alternate": "src/test/java/{}Test.java",
      \      "template": [
      \        "package {dirname|dot};",
      \        "",
      \        "public class {basename} {",
      \        "    public {basename}() {",
      \        "        return;",
      \        "    }",
      \        "}",
      \      ]
      \    },
      \    "src/test/java/*Test.java": {
      \      "type": "test",
      \      "alternate": "src/main/java/{}.java",
      \      "template": [
      \        "package {dirname|dot};",
      \        "",
      \        "import org.junit.Test;",
      \        "import static org.junit.Assert.*;",
      \        "",
      \        "public class {basename}Test {",
      \        "    @Test",
      \        "    public void testSomeLibraryMethod() {",
      \        "        {basename} classUnderTest = new {}();",
      \        "        assertTrue(\"someLibraryMethod should return 'true'\", classUnderTest.someLibraryMethod());",
      \        "    }",
      \        "}",
      \      ],
      \    }
      \  }
      \}

" LSP
" nnoremap <silent> <buffer> gd        <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> <buffer> [d        <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> <buffer> K         <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> <buffer> gD        <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> <buffer> gi	       <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <buffer> gs	       <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> <buffer> gt	       <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> <buffer> gW	       <cmd>lua vim.lsp.buf.document_symbol()<CR>
" nnoremap <silent> <buffer> gt	       <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" nnoremap <silent> <buffer> <leader>r <cmd>lua vim.lsp.buf.rename()<CR>
