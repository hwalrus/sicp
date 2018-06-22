#lang racket

(define (square x)
  (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= (smallest-divisor n) n))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-inexact-milliseconds)))

; below is modified slightly to return true or false, so that we can find the first n
; primes from a given starting point.
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
(search-for-primes 100000000)    ;; takes about 1 millisecond
(search-for-primes 1000000000)   ;; takes between 2 and 3 milliseconds
(search-for-primes 10000000000)  ;; takes between 7 and 8 milliseconds
(search-for-primes 100000000000) ;; takes between 25 and 27 milliseconds

;; result bears out premise that the testing algorithm has order of growth of
;; theta root n, and that finding primes from 1 billion is around root 10
;; slower than 100 million.
;;
;; this is compatible with the notion that programs run in time proportional to
;; the number of steps required for a computation.
      