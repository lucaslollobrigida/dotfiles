{:user
 {:min-lein-version    "2.9.0"
  :repositories        [["central"  {:url "https://repo1.maven.org/maven2/" :snapshots false}]
                        ["clojars"  {:url "https://clojars.org/repo/"}]]}
 :nrepl {:plugins      [[nrepl/lein-nrepl "0.3.2"]
                        [cider/cider-nrepl "0.25.3"]
                        [refactor-nrepl "2.5.0-SNAPSHOT"]]
         :repl-options {:timeout 120000}}}
