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

(def log (atom ""))

(defn add1 [x]
  (future (swap! log
                 (fn [log] (do (Thread/sleep 1000)
                               (str log "add1")))))
  (+ x 1))

(defn square [x]
  (future (swap! log
                 (fn [log] (str log "square"))))
  (* x x))

(square (add1 1)) ; => 4
@log ; => "add1square"

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
