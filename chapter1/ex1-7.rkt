#lang racket

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (square x)
  (* x x))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

;; Problem for small numbers where x < 0.0001 - increasingly inaccurate.
;; For large numbers e.g. 10000000000000000000000000000000000000000000000000,
;; the machine precision for numbers isn't sufficient to hold the small
;; decimals needed for the comparison

(define (good-enough2? new old)
  (< (/ (abs (- new old))
        old)
     0.001))

(define (sqrt-iter2 guess previous x)
  (if (good-enough2? guess previous)
      guess
      (sqrt-iter2(improve guess x)
                 guess
                 x)))

(define (sqrt2 x)
  (sqrt-iter2 1.0 x x))
      