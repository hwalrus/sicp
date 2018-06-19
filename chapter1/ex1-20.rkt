#lang racket


(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(gcd 206 40)


; Using applicative-order, remainder is called 4 times
;
; (gcd 206 40)
;  (if (= 40 0)
;      206
;      (gcd 40 (remainder 206 40))))
;
; (gcd 40 (remainder 206 40)) <<-- here
; (gcd 40 6)
;
;  (if (= 6 0)
;      40
;      (gcd 6 (remainder 40 6))))
;
; (gcd 6 (remainder 40 6))  <<-- here
; (gcd 6 4)
;
;  (if (= 4 0)
;      6
;      (gcd 4 (remainder 6 4))))
;
; (gcd 4 (remainder 6 4)) <<--- here
; (gcd 4 2)
;
;  (if (= 2 0)
;      4
;      (gcd 2 (remainder 4 2))))
;
; (gcd 2 (remainder 4 2))  <<--- here
; (gcd 2 0)
;
;  (if (= 0 0)
;      2
;      (gcd 0 (remainder 2 0))))
;
; 2
;
;
;
; Normal order substitution method is a lot more of a pain - remainder is called 18 times
;
;
; (gcd 206 40)
; (if (= 40 0)
;       206
;       (gcd 40 (remainder 206 40)))
;
; (gcd 40 (remainder 206 40))
;
; (if (= (remainder 206 40) 0)
;     40
;     (gcd (remainder 206 40)
;          (remainder 40 (remainder 206 40))))
;
; (if (= 6 0)  ;; <<---- here
;     40
;     (gcd (remainder 206 40)
;          (remainder 40 (remainder 206 40))))
;
; (gcd (remainder 206 40)
;      (remainder 40 (remainder 206 40)))
;
; (if (= (remainder 40 (remainder 206 40)) 0)
;     (remainder 206 40)
;     (gcd (remainder 40 (remainder 206 40))
;          (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
;
; (if (= 4 0)   ;; <<----- twice here
;     (remainder 206 40)
;     (gcd (remainder 40 (remainder 206 40))
;          (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
;
; (gcd (remainder 40 (remainder 206 40))
;      (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;
; (if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0)
;     (remainder 40 (remainder 206 40))
;     (gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;          (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))))
;
; (if (= 2 0)    ;;  <---- 4 times here
;     (remainder 40 (remainder 206 40))
;     (gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;          (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))))
;
; (gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;      (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
;
; (if (= (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) 0)
;     (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;     (gcd (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;          (remainder (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;                     (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))
;
; (if (= 0 0)  ;; <<----- 7 times here
;     (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;     (gcd (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;          (remainder (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;                     (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))
;
; (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;
; 2  ;; <<----- 4 more times
;
; so, looks like 18 times in total
