#lang racket

; Single Fib transform T01
;                            a1 <- bq + aq + ap
;                            b1 <- bp + aq
;
; Double Fib transform T01^2 = Tp'q'
;
;                            a2 <- b1.q + a1.q + a1.p
;                            b2 <- b1.p + a1.q
;
;                            a2 <- (bp + aq).q + (bq + aq + ap).q + (bq + aq + ap).p
;                            b2 <- (bp + aq).p + (bq + aq + ap).q
;
;                            b2 <- bp^2 + apq + bq^2 + aq^2 + apq
;                            b2 <- b(p^2 + q^2) + a(q^2 + 2pq)
;
; Therefore p' = p^2 + q^2, q' = q^2 + 2pq
;
; Need to get 0, 1, 1, 2, 3, 5, 8, 13, 21

(define (even? x)
  (= (remainder x 2) 0))

(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (square x)
  (* x x))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count) (fib-iter a
                                 b
                                 (+ (square p) (square q))
                                 (+ (* 2 p q) (square q))
                                 (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))

(fib 0)
(fib 1)
(fib 2)
(fib 3)
(fib 4)
(fib 5)
(fib 6)
(fib 7)
(fib 8)
