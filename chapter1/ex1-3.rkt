#lang racket

(define (sos x y)
  (define (square x)
    (* x x))
  (+ (square x)
     (square y)))

(define (sum-of-2-largest x y z)
  (cond ((and (< x y) (< x z)) (sos y z))
        ((and (< y x) (< y z)) (sos x z))
        (else (sos x y))))

(sum-of-2-largest 1 2 3)
(sum-of-2-largest 1 3 2)
(sum-of-2-largest 2 1 3)
(sum-of-2-largest 2 3 1)
(sum-of-2-largest 3 1 2)
(sum-of-2-largest 3 2 1)
  