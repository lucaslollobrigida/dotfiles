{:user
 {:min-lein-version    "2.9.0"
  :repositories        [["central"  {:url "https://repo1.maven.org/maven2/" :snapshots false}]
                        ["clojars"  {:url "https://clojars.org/repo/"}]
                        ["nu-maven" {:url "s3p://nu-maven/releases/" :region "sa-east-1"}]]
  :plugin-repositories [["nu-maven" {:url "s3p://nu-maven/releases/"}]]
  :plugins             [[cider/cider-nrepl "0.23.0"]
                        [lein-kibit "0.1.7"]
                        [s3-wagon-private "1.3.3"]
                        [lein-ancient "0.6.15"]]
  :dependencies        [[cljdev "0.9.0"]]}

 :repl {:plugins      [[cider/cider-nrepl "0.23.0"]
                       [refactor-nrepl "2.5.0-SNAPSHOT"]]
        :injections   [(require 'nu)]
        :dependencies [[cljdev "0.9.0"]]
        :repl-options {:timeout 120000}}}
