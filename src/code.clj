(def counter (atom ""))

(do
  (future
    (swap! counter #(str % "foo")))
  (future
    (swap! counter #(str % "bar"))))

@counter

(reset! counter "")

(do
  (future
    (swap! counter #(do (Thread/sleep 1000)
                        (str % "foo"))))
  (future
    (swap! counter #(str % "bar"))))

@counter

; does not work; probably because of `identical`

; (reset! counter "")

; (do
;   (future
;     (compare-and-set! counter
;                       ""
;                       (str @counter "foo")))
;   (future
;     (compare-and-set! counter
;                       "foo"
;                       (str @counter "bar"))))

; @counter
