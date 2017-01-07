;;; task 1
(define (hailstone n)
  (define (helper n l)
    (cond
      ((= n 1) l)
      ((even? n) (helper (/ n 2) (cons (/ n 2) l)))
      (else (helper (+ (* 3 n) 1) (cons (+ (* 3 n) 1) l)))
    )
  )
  (reverse (helper n (cons n '())))
)

;;; task 2
(define (divisors n)
  (define (helper n k res)
    (cond 
      ((< n k) res)
      ((= (modulo n k) 0) (helper (/ n (expt (car (count-divisor n k)) (cadr (count-divisor n k)))) (+ k 1) (cons (count-divisor n k) res)))
      (else (helper n (+ k 1) res))
    )
  )
  (if (prime? n)
      (list (list n 1))
      (reverse (helper n 2 '()))
  )
)

(define (count-divisor n k)
  (define (helper n k cnt)
    (if (= (modulo n k) 0)
        (helper (/ n k) k (+ cnt 1))
        (list k cnt)
    )
  )
  (helper n k 0)
)

(define (has-divisor? n k)
  (cond ((< k 2) #false)
        ((= (modulo n k) 0) #true)
        (else (has-divisor? n (- k 1)))
  )
)

(define (prime? n)
  (not (has-divisor? n (ceiling (sqrt n))))
)

