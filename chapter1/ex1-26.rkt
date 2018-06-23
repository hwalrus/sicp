#lang racket

; The difference is that the original expmod procedure

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

; is subtly different in that the even check now calls expmod twice

        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m))
                    m))

; which is then called twice more on each subsequent calls to expmod
;
; so the process has turned from theta log n to theta log (2 ^ n) which is
; n . log 2 or just theta n