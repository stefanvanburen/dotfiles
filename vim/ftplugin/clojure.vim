" We don't want ' or ` being auto-paired in clojure
if ! exists('b:AutoPairs')
	let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"'}
endif
