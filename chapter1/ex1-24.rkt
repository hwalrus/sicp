#lang racket

(#%require (lib "27.ss" "srfi"))

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

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
    (try-it (+ 1 (random-integer (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))  

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-inexact-milliseconds)))

(define (start-prime-test n start-time)
  (cond ((fast-prime? n 3)
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
  (search-for greater-than 100))

(define (search-for start primes-remaining)
  (cond ((> primes-remaining 0)
         (if (timed-prime-test start)
             (search-for (+ start 1) (- primes-remaining 1))
             (search-for (+ start 1) primes-remaining)))))
         
(search-for-primes 10000)
(search-for-primes 100000)
(search-for-primes 1000000)
(search-for-primes 10000000)
(search-for-primes 100000000)    
(search-for-primes 1000000000)   
(search-for-primes 10000000000)  
(search-for-primes 100000000000) 

; The Fermat test has order of growth theta log n (to the base 2).

; log 1,000,000 = 19.9
; root 1,000,000 = 1,0000
;
; So we'd expect the Fermat test to be considerably faster.
;
; Running the above prime tests start from 100 billion, still takes 0 milliseconds to
; find the primes. If we bump up the number of guesses to 100, then it starts to take
; half a millisecond to calculate.
;
; Even if we start looking from a very large starting point, it doesn't ever seem to
; take more than half a millisecond.

(search-for-primes 1000000000000)
(search-for-primes 10000000000000)
(search-for-primes 100000000000000) 