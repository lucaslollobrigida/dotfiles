return {
  lazy_load = function(load)
    load "vim-projectionist"
    load "vim-dispatch"
    load "vim-rfc"
  end,

  plugins = function(use)
    use { "mhinz/vim-rfc", opt = true }
    use { "tpope/vim-projectionist", opt = true }
    use { "tpope/vim-dispatch", opt = true }
  end,

  setup = function()
    local clojure_test = {
      type = "test",
      alternate = "src/{}.clj",
      template = { "(ns {dot|hyphenate}-test", "(:require [clojure.test :refer [deftest is testing]]))" },
    }

    local clojure_deps_actions = {
      dispatch = "clj -M:repl",
      make = "clj -M:check",
      start = "clj -M:run",
    }

    local clojure_lein_actions = {
      dispatch = "lein repl",
      make = "lein check",
      start = "lein run",
    }

    local function clojure_project(test_path)
      local test_pattern = string.format("%s/*_test.clj", test_path)

      return function(root_pattern, actions)
        local actions_pattern = string.format("*.clj|%s", root_pattern)

        return {
          [actions_pattern] = actions,
          ["deps.edn"] = {
            type = "config",
          },
          ["src/*.clj"] = {
            type = "source",
            alternate = string.format("%s/{}_test.clj", test_path),
            template = { "(ns {dot|hyphenate})" },
          },
          [test_pattern] = clojure_test,
        }
      end
    end

    local clojure_standard = clojure_project "test/unit"
    local clojure_legacy = clojure_project "test"

    local clojure_lein_standard = clojure_standard("project.clj", clojure_lein_actions)
    local clojure_lein_legacy = clojure_legacy("project.clj", clojure_lein_actions)

    local clojure_deps_standard = clojure_standard("deps.edn", clojure_deps_actions)
    local clojure_deps_legacy = clojure_legacy("deps.edn", clojure_deps_actions)

    local go_standard = {
      ["*.go|go.mod"] = {
        dispatch = "go test ./...",
        make = "go build",
      },
      ["go.mod"] = {
        type = "config",
      },
      ["*.go"] = {
        alternate = "{}_test.go",
        type = "source",
      },
      ["*_test.go"] = {
        alternate = "{}.go",
        type = "test",
      },
    }

    local maven_standard = {
      ["*.scala|*.sbt"] = {
        test = "bloop test root",
        console = "bloop console root",
        make = "bloop compile root",
        start = "bloop run root",
      },
      ["*.sbt"] = {
        type = "config",
      },
      ["src/main/scala/*.scala"] = {
        alternate = { "src/test/scala/{}Suite.scala", "src/test/scala/{}Spec.scala" },
        type = "source",
      },
      ["src/test/scala/*Suite.scala|src/test/scala/*Spec.scala"] = {
        dispatch = "bloop test --no-color -o {dot}Spec",
        alternate = "src/main/scala/{}.scala",
        type = "test",
      },
      ["src/main/java/*.java"] = {
        alternate = "src/test/java/{}Test.java",
        type = "source",
      },
      ["src/test/java/*Test.java"] = {
        alternate = "src/main/java/{}.java",
        type = "test",
      },
    }

    vim.g.projectionist_heuristics = {
      ["deps.edn&test/unit/"] = clojure_deps_standard,
      ["deps.edn&!test/unit/"] = clojure_deps_legacy,
      ["project.clj&test/unit/"] = clojure_lein_standard,
      ["project.clj&!test/unit/"] = clojure_lein_legacy,
      ["go.mod"] = go_standard,
      ["build.sbt"] = maven_standard,
    }
  end,
}
