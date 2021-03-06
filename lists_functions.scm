;;; create list from A to B

(define (accumulate op nv a b term next)
  (if (> a b)
      nv
      (op (term a) (accumulate op nv (next a) b term next))
  )
)

; cons - Returns a newly allocated pair whose first element is a and second element is d.
; > (cons 1 2)
; '(1 . 2)
; > (cons 1 '())
; '(1)

(define (make-list a b)
  (if (> a b)
      a
      (accumulate cons '() a b (lambda (x) x) (lambda (x) (+ 1 x)))
  )
)

;;; lenght of list

; cdr - Returns the second element of the pair p.
; > (cdr '(1 2))
; '(2)
; > (cdr '(1))
; '()

(define (len l)
  (if (null? l)
      0
      (+ 1 (len (cdr l)))
  )
)

; > (len '(1 2 3 4 5) )
; 5

;;; reverse list

; car - Returns the first element of the pair p.
; > (car '(1 2))
; 1
; > (car (cons 2 3))
; 2

(define (rev l)
  (define (rev-acc l res)
    (if (null? l)
        res
        (rev-acc (cdr l) (cons (car l) res))
    )
  )
  (rev-acc l '())
)

;;; lenght of list with accumulator

(define (len-acc l)
  (define (acc op nv start pred next)
    (if (pred start)
        nv
        (acc op (next nv) (op start) pred next)
    )
  )
  (acc cdr 0 l (lambda (x) (null? x)) (lambda (x) (+ x 1)))
)

;;; append an element in the beginnig of the list

(define (pre-append elem l)
  (if (null? l)
      elem
      (cons elem l)
  )
)

;;; append an element in the end of the list

(define (append-2 elem l)
  (if (null? l)
      (list elem)
      (rev (cons elem (rev l)))
  )
)

; > (append-2 1 '(4 5 6 1 2))
; (4 5 6 1 2 1)

(define (append-3 elem l)
  (if (null? l)
      (list elem)
      (cons (car l) (append-3 elem (cdr l)))
  )
)

; > (append-3 '(8 7 6 5 4 3 2 1) 55)
; (8 7 6 5 4 3 2 1 55)

;;; check if element exists in list

(define (exists? x l)
  (cond 
    ((null? l) #false)
    ((= (car l) x) #true)
    (else (exists? x (cdr l)))
  )
)

; > (exists? 4 '(1 2 3 5))
; #f
; > (exists? 4 '(1 2 3 4 5 4 5))
; #t

;;; get the elements from a list without the first N

(define (my-list-tail l n)
  (if (= n 0)
      l
      (my-list-tail (cdr l) (- n 1))
  )
)

; > (my-list-tail '(1 2 3 4 5) 3)
; (4 5)
; > (my-list-tail '(1 2 3 4 5) 1)
; (2 3 4 5)
; > (my-list-tail '(1 2 3 4 5) 0)
; (1 2 3 4 5)

;;; get the N-th element (from 0)

(define (my-list-ref l n)
  (car (my-list-tail l n))
)

; > (my-list-ref '(1 2 3 4) 0)
; 1
; > (my-list-ref '(1 2 3 4) 3)
; 4

;;; append two lists

(define (append-two-lists l1 l2)
  (if (null? l1) 
      l2
      (cons (car l1) (append-two-lists (cdr l1) l2))
  )
)

; (append-two-lists '(1 2 3) '(4 5 6))
; (1 2 3 4 5 6)
; (append-two-lists '() '(4 5 6))
; (4 5 6)