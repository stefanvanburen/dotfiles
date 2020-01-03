{:user {:plugins
        [
         [venantius/ultra "0.6.0"],
         [cider/cider-nrepl "0.22.4"]
         [cljfmt "0.6.4"]]}

 :repl
 {:repl-options
  {:init (clojure.core.server/start-server {:accept 'clojure.core.server/io-prepl
                                            :address "localhost"
                                            :port 55555
                                            :name "lein"})}}}
