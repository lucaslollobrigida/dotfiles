(deftask cider "CIDER profile"
   []
   (require 'boot.repl)
   (swap! @(resolve 'boot.repl/*default-dependencies*)
          concat '[
                   ; [nrepl "0.7.0-SNAPSHOT"]
                   ; [cider/nrepl "0.3.0"]
                   ; [cider/cider-nrepl "0.22.4"]
                   [compliment "0.3.9"]
                   [slamhound "1.5.5"]
                   [jonase/kibit "0.1.5" :exclusions [org.clojure/clojure]]])
   ; (swap! @(resolve 'boot.repl/*default-middleware*)
   ;        concat '[cider.nrepl/cider-middleware])
   identity)
