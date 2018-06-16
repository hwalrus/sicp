#lang racket

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; Very interesting! We're returning an operator + or - based on whether b is +ve or -ve
; and applying that operator to a and b.

; i.e. if b is +ve, it is added to a. If it's -ve, it's subtracted i.e. absolute value
; of b is added to a

; (a-plus-abs-b 10 5)
; sub -> ((if (> 5 0) + -) 10 5))
;     -> (+ 10 5)
;     -> 15

; (a-plus-abs-b 5 10)
; sub -> ((if (> 10 0) + -) 5 10))
;     -> (+ 5 10)
;     -> 15

; (a-plus-abs-b -10 5)
; sub -> ((if (> 5 0) + -) -10 5))
;     -> (+ -10 5)
;     -> 5

; (a-plus-abs-b 5 -10)
; sub -> ((if (> -10 0) + -) 5 -10))
;     -> (- 5 -10)
;     -> 15

; (a-plus-abs-b -5 -10)
; sub -> ((if (> -10 0) + -) -5 -10))
;     -> (- -5 -10)
;     -> 5

