#lang racket

(define (p) (p))
(define (test x y)
  (if (= x 0)
      0
      y))

; what happens if you evaluate (test 0 (p))

; First step in applicative order is to evaluate the arguments to test
; 0 is a primitive, and (p) is evaluated to ((p)) i.e.

; (test 0 (p))
; (test 0 ((p))
; (test 0 (((p))) etc

; and we never get further than that.

; In normal order, we expand the operator first

; (if (= 0 0)
;     0
;     (p))

; if and cond are special forms where the consequents and alternatives are
; not evaluated until it's determined which should be run, so here the
; (= 0 0) is evaluated. True is the result, so 0 is the final answer