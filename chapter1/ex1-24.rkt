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

; note use of random-integer that's required for very large number.s
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
  (search-for greater-than 3))

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
; Starting at 10,000 we see that with a perhaps arbitrarily large maximum of 100 gueses
; per number, it takes between 0 and 1 millisecond to get the next prime.
;
; However, when we increase this to 100 billion, the range has only increased from 1 to
; 3 milliseconds, still takes 0 milliseconds compared to between 15 and 27 milliseconds
; for the improved smallest divisor method.
;
; Even if we start looking from a very large starting point, such as 100 trillion, the
; time taken is still around 3 milliseconds.
;
; This is consistent with log n growth (twice as many digits is about twice as slow)

(search-for-primes 1000000000000)
(search-for-primes 10000000000000)
(search-for-primes 100000000000000) 