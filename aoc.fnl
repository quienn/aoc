;;; Advent of Code helpers

(fn time [f ...]
  "Returns the time in seconds the function `fn` took to execute."
  (let [start (os.clock)
        ret [(f ...)]]
    (print (.. "run-time total: " (- (os.clock) start) "s"))
    (table.unpack ret)))

{: time}
