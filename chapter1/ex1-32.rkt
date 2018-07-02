#lang racket

(define (square x) (* x x))
(define (identity x) x)
(define (inc x) (+ x 1))
(define (times x y) (* x y))
(define (sum x y) (+ x y))

(define (accumulate-i combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))

(define (accumulate-r combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
         (accumulate-r combiner null-value term (next a) next b))))

(define (factorial-i n)
  (accumulate-i times 1 identity 1 inc n))

(define (factorial-r n)
  (accumulate-r times 1 identity 1 inc n))

(define (sum-of-squares n)
  (accumulate-i sum 0 square 1 inc n))

(define (pi-r)
  (define (pi-term x)
    (if (= 0 (remainder x 2))
        (/ x (+ x 1))
        (/ (+ x 1) x)))
  (define (pi-next x) (inc x))
  (* 4
     (accumulate-r * 1 pi-term 2 pi-next 100)
     ))

(sum-of-squares 3)
(factorial-i 5)
(factorial-i 6)
(factorial-r 6)
(pi-r)
