{:user {:dependencies [[compliment "0.3.9"]
                       [slamhound "1.5.5"]
                       [pjstadig/humane-test-output "0.10.0"]]
        :plugins [[lein-pprint "1.2.0"]
                  [lein-kibit "0.1.7"]
                  [pjstadig/humane-test-output "0.10.0"]
                  [com.jakemccrary/lein-test-refresh "0.24.1"]]
        :injections [(require 'pjstadig.humane-test-output)
                     (pjstadig.humane-test-output/activate!)]}}
