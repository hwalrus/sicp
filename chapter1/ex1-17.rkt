#lang racket

(define (halve x)
  (/ x 2))

(define (double x)
  (+ x x))

(define (even? x)
  (= (remainder x 2) 0))

(define (* a b)
  (define (*iter a b n)
    (cond ((= b 0) n)
          ((even? b) (*iter (double a) (halve b) n))
          (else (*iter a (- b 1) (+ n a)))))
  (*iter a b 0))

(* 0 0)

(* 1 0)
(* 1 1)
(* 1 2)
(* 1 3)
(* 1 4)

(* 2 0)
(* 2 1)
(* 2 2)
(* 2 3)
(* 2 4)

(* 3 0)
(* 3 1)
(* 3 2)
(* 3 3)
(* 3 4)
