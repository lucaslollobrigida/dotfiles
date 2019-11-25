{:repl {:repl-options
        {:init (clojure.core.server/start-server {:accept 'clojure.core.server/io-prepl
                                                  :address "localhost"
                                                  :port 5998
                                                  :name "lein"})}}}
{:user {:dependencies [[compliment "0.3.9"]
                       [slamhound "1.5.5"]
                       [pjstadig/humane-test-output "0.10.0"]]
        :plugins [[lein-pprint "1.2.0"]
                  [lein-kibit "0.1.7"]
                  [pjstadig/humane-test-output "0.10.0"]
                  [com.jakemccrary/lein-test-refresh "0.24.1"]]
        :injections [(require 'pjstadig.humane-test-output)
                     (pjstadig.humane-test-output/activate!)]}}
        ; :test-refresh {:notify-command ["terminal-notifier" "-title" "Tests" "-message"]
        ;                        :quiet true
        ;                        :changes-only true}}}
