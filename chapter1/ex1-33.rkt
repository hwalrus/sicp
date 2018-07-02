#lang racket

(#%require (lib "27.ss" "srfi"))

(define (square x) (* x x))
(define (identity x) x)
(define (inc x) (+ x 1))
(define (times x y) (* x y))
(define (sum x y) (+ x y))

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

(define (prime? x)
  (fast-prime? x 100))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

; define both a recursive and iterative version
(define (filtered-accumulate-i filter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (if (filter a)
                           (combiner (term a) result)
                           result)
              )))
  (iter a null-value))

(define (filtered-accumulate-r filter combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (if (filter a)
                    (term a)
                    null-value)
                (filtered-accumulate-r filter combiner null-value term (next a) next b))))


(define (sum-of-squared-primes-i a b)
  (filtered-accumulate-i prime? sum 0 square a inc b))

(define (sum-of-squared-primes-r a b)
  (filtered-accumulate-r prime? sum 0 square a inc b))

(define (product-of-relative-primes-i n)
  (define (relatively-prime? x) (= 1 (gcd x n)))    
  (filtered-accumulate-i relatively-prime? times 1 identity 1 inc (- n 1)))

(define (product-of-relative-primes-r n)
  (define (relatively-prime? x) (= 1 (gcd x n)))    
  (filtered-accumulate-r relatively-prime? times 1 identity 1 inc (- n 1)))

(sum-of-squared-primes-i 2 20)
(sum-of-squared-primes-r 2 20)

(product-of-relative-primes-i 20)
(product-of-relative-primes-r 20)

