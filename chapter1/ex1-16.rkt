#lang racket

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (square x)
  (* x x))

(define (even? n)
  (= (remainder n 2) 0))


"recursive process"
(fast-expt 2 2)
(fast-expt 2 3)
(fast-expt 2 4)
(fast-expt 5 2)
(fast-expt 5 3)
(fast-expt 5 4)

(define (fast-expt-iter b n)
  (define (fast-iter a b n)
    (cond ((= n 0) a)
          ((even? n) (fast-iter a (square b) (/ n 2)))
          (else (fast-iter (* a b) b (- n 1)))))
  (fast-iter 1 b n))

"iterative process"
(fast-expt-iter 2 2)
(fast-expt-iter 2 3)
(fast-expt-iter 2 4)
(fast-expt-iter 5 2)
(fast-expt-iter 5 3)
(fast-expt-iter 5 4)
