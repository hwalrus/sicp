#lang racket

(define (identity x) x)
(define (inc x) (+ x 1))

(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* (term a) result))))
  (iter a 1))

(define (factorial-i n)
  (product-iter identity 1 inc n))

(factorial-i 0)
(factorial-i 1)
(factorial-i 2)
(factorial-i 3)
(factorial-i 4)
(factorial-i 5)
(factorial-i 6)

(define (product-recur term a next b)
  (if (> a b)
      1
      (* (term a)
         (product-recur term (next a) next b))))

(define (factorial-r n)
  (product-recur identity 1 inc n))

(factorial-r 0)
(factorial-r 1)
(factorial-r 2)
(factorial-r 3)
(factorial-r 4)
(factorial-r 5)
(factorial-r 6)

(display "calculating pi")
(newline)

(define (pi-r)
  (define (pi-term x)
    (if (= 0 (remainder x 2))
        (/ x (+ x 1))
        (/ (+ x 1) x)))
  (define (pi-next x) (inc x))
  (* 4
     (product-recur pi-term 2 pi-next 10)
     ))

(pi-r)

(define (pi-i)
  (define (pi-term x)
    (if (= 0 (remainder x 2))
        (/ x (+ x 1))
        (/ (+ x 1) x)))
  (define (pi-next x) (inc x))
  (* 4
     (product-iter pi-term 2 pi-next 10)
     ))

(pi-i)
