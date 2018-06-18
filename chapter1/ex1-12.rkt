#lang racket

(define (pascal r n)
  (cond ((= n 1) 1)
        ((= r 2) 1)
        ((= r n) 1)
        (else (+ (pascal (- r 1) (- n 1))
                 (pascal (- r 1) n)))))

"row 1"
(pascal 1 1)

"row 2"
(pascal 2 1)
(pascal 2 2)

"row 3"
(pascal 3 1)
(pascal 3 2)
(pascal 3 3)

"row 4"
(pascal 4 1)
(pascal 4 2)
(pascal 4 3)
(pascal 4 4)

"row 5 etc"
(pascal 5 1)
(pascal 5 2)
(pascal 5 3)
(pascal 5 4)
(pascal 5 5)