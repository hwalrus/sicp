#lang racket

(#%require (lib "27.ss" "srfi"))

(define (square x)
  (* x x))

(define (square-if-non-trivial-root a n)
  (if (and (not (or (= a 1)
                    (= a (- n 1))))
           (= (remainder (square a) n) 1))
      0
      (square a)))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square-if-non-trivial-root (expmod base (/ exp 2) m) m)
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (miller-rabin-test n)
  (define (try-it a)
    (= (expmod a (- n 1) n) 1))
  (try-it (+ 1 (random-integer (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((miller-rabin-test n) (fast-prime? n (- times 1)))
        (else false)))  

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-inexact-milliseconds)))

(define (start-prime-test n start-time)
  (cond ((fast-prime? n 100)
         (report-prime (- (current-inexact-milliseconds) start-time))
         #t)
        (else #f)))     

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (search-for-primes greater-than)
  (newline)
  (display "starting from ")
  (display greater-than)
  (search-for greater-than 500))

(define (search-for start primes-remaining)
  (cond ((> primes-remaining 0)
         (if (timed-prime-test start)
             (search-for (+ start 1) (- primes-remaining 1))
             (search-for (+ start 1) primes-remaining)))))

; look for the first 500 primes starting from 2. 
(search-for-primes 2)
