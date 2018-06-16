#lang racket

(define (cbrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (cbrt-iter (improve guess x)
                 x)))

(define (improve guess x)
  (/ (+ (/ x (square guess))
        (* 2 guess))
     3))

(define (square x)(* x x))
(define (cube x) (* x x x))
  
(define (cbrt x)
  (cbrt-iter 4.0 x))
  
(define (good-enough? guess x)
  (< (abs (- (cube guess) x)) 0.001))    

(cbrt 8)
(cbrt 27)