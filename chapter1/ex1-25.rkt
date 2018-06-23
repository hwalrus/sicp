#lang racket

(#%require (lib "27.ss" "srfi"))

(define (square x)
  (* x x))

(define (expmod base exp m)
  (remainder (fast-expt base exp) m))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

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

; Just running this for primes starting from 10,000 and 100,000 shows that there's
; something disastrously wrong with time taken varying between 80 and 3000 milliseconds.

; The difference is that with the original expmod procedure, we're always calling
; remainder after the expansion of the next recursive call. E.g. just considering even
; numbers, we have
;
; (remainder (square (expmod base (/ exp 2) m))
;            m))
;
; which after several recursive call looks something like
;
; (remainder (square (remainder (square (remainder (square (remainder (square ...
;                                                                     m))
;                                                  m)) 
;                               m))
;             m))
;
; etc, so the number being passed back through the stack of recursive call is never larger
; than the initial test prime number
;
; Compare this with fast-exp where the return value from recursive calls is constantly being
; squared. Again, just considering even numbers
;
; (square (fast-expt b (/ n 2))))
;
; which expanded will look like
;
; (square (square (square (square (square (fast-expt b (/ n 2))))
;
; the number being squared will become every larger requiring more memory and resources to
; process, and an escalating amount of time required to calculate.
;
; The original expmod procedure is therefore far superior.