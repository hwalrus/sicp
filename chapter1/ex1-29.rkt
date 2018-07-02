#lang racket

(define (cube x) (* x x x))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

(integral cube 0 1 0.01)    ; 0.24998750000000042
(integral cube 0 1 0.001)   ; 0.249999875000001

(define (simpsons f a b n)
  (define h (/ (- b a)
               n))
  (define (mult-factor x)
    (cond ((= x 0) 1)
          ((= x n) 1)
          ((= 0 (remainder x 2)) 2)
          (else 4)))
  (define (increment x) (+ x 1))
  (define (simpsons-term x) (* (mult-factor x)
                               (f (+ a
                                     (* x h)))))
        
  (* (sum simpsons-term 0 increment n)
     (/ h 3)))

(simpsons cube 0 1 100)  ; exactly 1/4
(simpsons cube 0 1 1000) ; exactly 1/4
