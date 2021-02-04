#lang racket

;problem 1 my attempt
(define (sumList list)
  (if (null? list)
     0
     (if (number? (car list))
         (+ (car list)(sumList (cdr list)))
         (sumList (cdr list))
     )
  )
)

;problem 2 my attempt
(define (palindrome list)
  (equal? list (reverse list))
)

;problem 3 my attempt
(define (reverseList list)
  (if (null? list)
      null
      (append (reverseList (cdr list)) (list (car list)))
  )
)

;problem 4 class attempt
(define (get list index)
  (if (and (>= index 0) (< index (length list)))
      (if (= index 0)
          (car list)
          (get (cdr list) (- index 1)) ;substract the index until reaching 0
      )
      null
  )
)

;problem 5 my attempt
(define (removeList list index)
  (if(null? list)
     null
     (if(odd? index)
        (cons (car list) (removeList (cdr list) (+ index 1)))
        (removeList (cdr list) (+ index 1))
     )
  )
)

;problem 5 my attempt
(define (oddIndex list)
  (removeList list 0)
)


;problem 5 class attempt
(define (oddPositionsAux list boolean)
  (if (null? list)
      null ; or '()
      (if (equal? #t boolean) ;not same type so use equal
          (cons (car list) (oddPositionsAux (cdr list) (not boolean)))
          (oddPositionsAux (cdr list) (not boolean))
      )
  )
)

;problem 5 class attempt
(define (oddPositions list)
  (oddPositionsAux list #f)
)

;(cons/list/append '(2 3) '(4))

;(cdaddr'(a b (c d e)f))

;(list (car '(a 1 b))2)
;(car '(a 1 b))

;(reverse(cons '(8 4) '(4 8)))
;(cons'(10 13 8)(list(cdr'(8 4 5))))
;(list(cdr'(8 4 5)))
;((lambda(x)(* x x))3)
;(let ((x 2)(y 3))(+ x y))
;(append(cons'() '(1))(list 2 3))