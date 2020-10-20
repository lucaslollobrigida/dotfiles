{:user
 {:min-lein-version    "2.9.0"
  :repositories        [["central"  {:url "https://repo1.maven.org/maven2/" :snapshots false}]
                        ["clojars"  {:url "https://clojars.org/repo/"}]]
  :injections   [(require 'nu)]
  :plugins             [[s3-wagon-private "1.3.3"]
                        [lein-ancient "0.6.15"]
                        [nrepl/lein-nrepl "0.3.2"]
                        [cider/cider-nrepl "0.25.3"]
                        [refactor-nrepl "2.5.0-SNAPSHOT"]]
  :dependencies [[nrepl "0.7.0"]
                 [cljdev "0.9.0"]
                 [compliment "0.3.6"]
                 [com.cemerick/pomegranate "0.4.0"]
                 [org.tcrawley/dynapath "0.2.5"]
                 [me.raynes/fs "1.4.6"]]
  :repl-options {:timeout 120000}}}
