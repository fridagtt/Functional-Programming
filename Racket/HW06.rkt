#lang racket

;; ====================
;; Complete the following functions and submit your file to Canvas.
;; ====================
;; Do not change the names of the functions. 
;; Do not change the number of arguments in the functions.
;; If your file cannot be loaded by the Racket interpreted, your submission may be cancelled. Then, submit only code that works.
;; ====================
;; Grading instructions:
;; There is a series of test cases for each function. In order to state that your function "works as described", your output must be similar to the expected one in each case.

;; === sum ===

(define (sum matrix)
  (apply + (map (lambda (x) (apply + x)) matrix))
)

(display "=== sum ===\n")
(sum '((1 2 3) (4 5 6) (7 8 9))) ;; 45
(sum '((1 2) (30 40) (5 6) (70 80))) ;; 234
(sum '((8 9 5 6 7) (3 4 5 4 2))) ;; 53

;; === complete? ===

;;(define (completeAux? len graph)
  ;(if (null? graph)
     ; 0
     ; (if(= len (length (car graph)))
    ;     (completeAux? (length graph) (cdr graph))
   ;      #f
  ;    )
 ; )
;)

(define (complete? graph)
  (equal? (filter (lambda (x) (= (length x)(length graph))) graph) graph)
)

(display "=== complete? ===\n")
(complete? '((a b c) (b a c) (c a b) (d e) (e d))) ;; #f
(complete? '((a b) (b a))) ;; #t
(complete? '( (a c) (b a) (c a))) ;; #f

;; === msort ===

(define (merge left right)
  (cond
    ((null? left) right)
    ((null? right) left)
    ((<=(car left)(car right)) (cons (car left) (merge(cdr left) right)))
    (else (cons (car right) (merge left (cdr right))))
  )
)

(define (msort lst)
  (cond
    ((null? lst)null) ;if empty list
    ((=(length lst)1)lst) ;if length is 1
    (else
      (let
          (
            (left (take lst (quotient (length lst) 2)))
            (right (drop lst (quotient (length lst) 2)))
          )
          (merge (msort left) (msort right))
      )
    )
  )
)

(display "=== msort ===\n")
(msort '()) ;; '()
(msort '(1)) ;; '(1)
(msort '(10 35 8 2.6 4.7 12)) ;; '(2.6 4.7 8 10 12 35)
(msort '(1 4 7 9 3 4 8 10)) ;; '(1 3 4 4 7 8 9 10)

;; === sold-units ===

;; This should not be done! (but it helps)
(define sales 
  '(
    (105 (10 3) (4 2) (9 3))
    (106 (6 4) (8 1) (4 6))
    (107 (9 7) (12 1) (14 1) (10 4))
    (108 (4 1))
    (109 (7 21) (10 4) (14 6) (5 3))
  )
)

(define (sold-units-aux id sales)
  (if (null? sales)
      0
      (if (= id (caar sales))
          (cadar sales)
          (sold-units-aux id (cdr sales))
      )
  )

)
(define (sold-units id sales)
  (if (null? sales)
      0
      (+ (sold-units-aux id (cdar sales)) (sold-units id (cdr sales)))
  ) 	
)

(display "=== sold-units ===\n")
(sold-units 2 sales) ;; 0
(sold-units 9 sales) ;; 10
(sold-units 10 sales) ;; 11
(sold-units 14 sales) ;; 7

;; === insert ===

(define (insert x tree) ;devolver elemento como un arbol ;(cons 10 '(()()))
  (cond
    ((null? tree) (cons x '(()()))) ;edge case
    ((> x (car tree)) (append (list(car tree)) (list (cadr tree) (insert x (caddr tree))))) ;para respetar la estructura
    (else (append (list (car tree)) (list(insert x (cadr tree))) (cddr tree)))
  )
)

;(if (null? sales)
;   0
 ;  (+ (apply + (map cadr (filter(lambda (x) (=(car x)id)) (cdar sales)))) (sold-units id (cdr sales)))
;)

(display "=== insert ===\n")
(insert 1 '()) ;; '(1 () ())
(insert 3 '(1 () (5 () ()))) ;; '(1 () (5 (3 () ()) ()))
(insert 0 '(1 () (5 (3 () ()) (6 () ())))) ;; '(1 (0 () ()) (5 (3 () ()) (6 () ())))

;; == set ===

(define (set lst)
  (if (null? lst)
     '()
     (if (number? (car lst))
         (cons (car lst) (set (filter (lambda (x) (not (equal? x (car lst))))lst)))
         (set (cdr lst))
     )
  )
)

(display "=== set ===\n")
(set '(1 2 3 2 4 a (1 2) 5 2 3)) ;; '(1 4 5 2 3)
(set '(a b 3 4)) ;; '(3 4)
(set '(10 (a b 3) 4 (8) c d (a b 3) d c 11)) ;; '(10 4 11)

(define (union x y)
  (set (append x y))
)

(display "=== union ===\n")
(union '(1 2 3 4) '(3 4 5 6)) ;; '(1 2 3 4 5 6)
(union '(10 2 8 4) '()) ;; '(10 2 8 4)
(union '(2 a 8 4) '(b c d)) ;; '(2 8 4)

(define (internsection-aux num lst)
  (filter (lambda (x) (equal? num x)) lst)
)

(define (intersection x y)
  (cond
    [(or (null? x) (null? y)) '()]
    [else (apply append(map (lambda (x) (internsection-aux x y)) x)) ]
  )
)

(display "=== intersection ===\n")
(intersection '(1 2 3 4) '(3 4 5 6)) ;; '(3 4)
(intersection '(10 2 8 4) '()) ;; '()
(intersection '(2 a 8 4) '(b c 8 d)) ;; '(8)
