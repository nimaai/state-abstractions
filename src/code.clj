(def log (atom ""))

(do
  (future
    (swap! log (fn [l] (str l "foo"))))
  (future
    (swap! log (fn [l] (str l "bar")))))

@log ; => "foobar"

(reset! log "")

(do
  (future
    (swap! log (fn [l] (do (Thread/sleep 1000) (str l "foo")))))
  (future
    (swap! log (fn [l] (str l "bar")))))

@log ; => "foobar"

; does not work; probably because of `identical`

; (reset! log "")

; (do
;   (future
;     (compare-and-set! log
;                       ""
;                       (str @log "foo")))
;   (future
;     (compare-and-set! log
;                       "foo"
;                       (str @log "bar"))))

; @log
