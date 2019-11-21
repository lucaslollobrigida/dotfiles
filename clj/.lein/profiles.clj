{:repl {:repl-options
        {:init (clojure.core.server/start-server {:accept 'clojure.core.server/io-prepl
                                                  :address "localhost"
                                                  :port 5998
                                                  :name "lein"})}}}
{:user {:plugins [[lein-pprint "1.2.0"]
                  [lein-kibit "0.1.7"]]
        :dependencies [[compliment "0.3.9"]
                       [slamhound "1.5.5"]]}}

