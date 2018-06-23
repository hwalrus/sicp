#lang racket

(define (square x)
  (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n check-val)
    (= (expmod check-val n n) check-val))

(define (fermat-iter n guess)
  (cond ((= guess 0) true)
        ((fermat-test n guess) (fermat-iter n (- guess 1)))
        (else false)))  

(define (rigorous-fermat? n)
  (newline)
  (display n)
  (cond ((fermat-iter n (- n 1))
          (display " looks prime"))
         (else (display " is not prime"))))

(rigorous-fermat? 11)   ; real prime
(rigorous-fermat? 12)   ; not prime
(rigorous-fermat? 561)  ; carmichael numbers follow
(rigorous-fermat? 1105)
(rigorous-fermat? 1729)
(rigorous-fermat? 2465)
(rigorous-fermat? 6601)


