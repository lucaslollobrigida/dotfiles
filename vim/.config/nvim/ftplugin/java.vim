if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

setlocal shiftwidth=4
setlocal tabstop=4
setlocal comments=s1:/*,mb:*,ex:*/,://
setlocal commentstring=//\ %s

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
