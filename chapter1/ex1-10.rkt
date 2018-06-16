#lang racket

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

(A 1 10)
(A 2 4)
(A 3 3)

(define (f n) (A 0 n))
(define (g n) (A 1 n))
(define (h n) (A 2 n))
(define (k n) (* 5 n n))

(f 10)
; (f n) computes 2n

; (g 2)
; (A 1 2)
; (A 0 (A 1 1))
; (A 0 2)
; 4
; (A 1 3)
; (A 0 (A 1 2))
; (A 0 (A 0 (A 0 1))
; (A 0 (A 0 2)
; (A 0 4)
; 8
; (g n) computes 2^n
(g 2)
(g 3)
(g 4)

; (h 2)
; (A 2 2)
; (A 1 (A 2 1)
; (A 1 2)
; (A 0 (A 1 1)
; (A 0 2)
; 4

; (h 3)
; (A 2 3)
; (A 1 (A 2 2)
; (A 1 (A 1 (A 2 1)
; (A 1 (A 1 2)
; (A 1 (A 0 (A 1 1)
; (A 1 (A 0 2)
; (A 1 4)
; (A 0 (A 1 3)
; (A 0 (A 0 (A 1 2)
; (A 0 (A 0 (A 0 (A 1 1)
; (A 0 (A 0 (A 0 2)
; (A 0 (A 0 4)
; (A 0 8)
; 16
(h 1)
(h 2)
(h 3)
(h 4)
(h 5)

; actually quite tricky : (h n) = 2^(h(n-1))

; also very impressed that the interpreter can actually calculate (h 5)!