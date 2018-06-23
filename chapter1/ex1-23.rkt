#lang racket

(define (square x)
  (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (next test-divisor)
  (cond ((= test-divisor 2) 3)
        (else (+ test-divisor 2))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= (smallest-divisor n) n))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-inexact-milliseconds)))

(define (start-prime-test n start-time)
  (cond ((prime? n)
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
(search-for-primes 100000000)    ;; takes between 0 and 1 milliseconds
(search-for-primes 1000000000)   ;; takes between 1 and 2 milliseconds
(search-for-primes 10000000000)  ;; takes between 4 and 5 milliseconds
(search-for-primes 100000000000) ;; takes between 15 and 17 milliseconds

; the new procedure isn't twice as fast. For the primes starting at 100 billion, it
; take between 15 and 17 milliseconds compared to 25 and 27 milliseconds.

; While we are avoiding calling find-divisor for all the even numbers greater than 2,
; there is some extra overhead in the next procedure call
;
; i.e. we are replacing
;
; (+ test-divisor 1)
;
; with
;
; (define (next test-divisor)
;   (cond ((= test-divisor 2) 3)
;         (else (+ test-divisor 2))))
;
; The extra instructions represent the difference between a naive expectation of a 2x
; performance improvement, and the actual result