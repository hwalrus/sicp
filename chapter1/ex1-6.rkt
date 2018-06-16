#lang racket

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (square x)
  (* x x))

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

(define (sqrt-iter2 guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter2 (improve guess x)
                     x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (sqrt2 x)
  (sqrt-iter2 1.0 x))


; (sqrt 9) -> 3.000...
; (sqrt2 9) -> stack overflow

; This is because the new-if is evaluated using applicative order, so is
; expanded. The expansion references sqrt-iter2, which again contains new-if,
; so as for 1.5 recurses until stack overflow occurs

; This implies that if if is defined in terms on cond, it is inherently
; recursive, so it must be a special form to be useful.

(define (foo x)
  (new-if (< x 1)
      x
      (foo (- x 1))))

; (foo 5) will have the same problem