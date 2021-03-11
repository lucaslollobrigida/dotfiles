{:user
 {:plugins      [[cider/cider-nrepl "0.25.9"]
                 [nrepl/lein-nrepl "0.3.2"]
                 [refactor-nrepl "2.5.1"]]
  :dependencies [[nrepl "0.8.3"] ;; "0.7.0"
                 [com.bhauman/rebel-readline "0.1.4"]]
  :aliases      {"rebl" ["trampoline" "run" "-m" "rebel-readline.main"]}}}
