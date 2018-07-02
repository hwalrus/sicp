#lang racket

(define (square x) (* x x))

(define (f g)
  (g 2))

(f square)
(f (lambda (z) (* z (+ z 1))))
(f f)

; (f f) will evaluate to (f 2), which is then evaluated to (2 2) which errors because the
; number 2 is not a procedure
;
; In the Racket interpreter, this gives you
;
; application: not a procedure;
; expected a procedure that can be applied to arguments
;  given: 2
;  arguments...: