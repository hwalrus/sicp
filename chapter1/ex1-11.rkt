#lang racket

(define (f-recursive n)
  (cond ((< n 3) n)
        (else (+ (f-recursive (- n 1))
                 (* 2 (f-recursive (- n 2)))
                 (* 3 (f-recursive (- n 3)))))))

(f-recursive -1)
(f-recursive 0)
(f-recursive 1)
(f-recursive 2)
(f-recursive 3)
(f-recursive 4)
(f-recursive 5)


(define (f-iterative n)
  (define (f-iter a b c count)
    (if (= count 0)
        c
        (f-iter (+ a
                   (* b 2)
                   (* c 3)
                   )
                a
                b
                (- count 1)
        )))
  (if (< n 0)
      n
      (f-iter 2 1 0 n)))

(f-iterative -1)
(f-iterative 0)
(f-iterative 1)
(f-iterative 2)
(f-iterative 3)
(f-iterative 4)
(f-iterative 5)