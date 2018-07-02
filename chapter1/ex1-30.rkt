#lang racket

(define (sum term a next b)
  (define (iter a result)
    (if (< (- b a) 0)
        result
        (iter (next a) (+ (term a) result))))
  (iter a 0))

(define (identity x) x)
(define (inc x) (+ x 1))

(define (sum-integers a b)
  (sum identity a inc b))

(sum-integers 0 5)
