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

;; === minmax ===

(define (minmax lst)
  (display "not yet implemented")
)

(display "=== minmax ===\n")
(minmax '(-4 10 -2 9 -10)) ;; '(-10 10)
(minmax '(3 4 -5 -9 18 6 7 11)) ;; '(-9 18)
(minmax '(-1 -10 -3 0 -8)) ;; '(-10 0)
(minmax '(9 1 2 3 6 5 4)) ;; '(1 9)

;; === modulo ===

(define (modulo x y)
  (cond
    [(= x 0) 0]
    [(< x y) x]
    [else (modulo(- x y) y)]
  )
)

(display "=== modulo ===\n")
(modulo 10 2) ;; 0
(modulo 15 4) ;; 3
(modulo 20 9) ;; 2
(modulo 77 10) ;; 7

;; === sum ===

(define (sum mA mB)
  (if(null? mA)
     '()
     (cons(map + (car mA) (car mB))(sum(cdr mA)(cdr mB)))
  )
)

(display "=== sum ===\n")
(sum '((1 2 3) (4 5 6) (7 8 9)) '((10 20 30) (40 50 60) (70 80 90))) ;; '((11 22 33) (44 55 66) (77 88 99))
(sum '((1 2) (30 40)) '((5 6) (70 80))) ;; '((6 8) (100 120))
(sum '((8 9 5 6 7)) '((3 4 5 4 2))) ;; '((11 13 10 10 9))
(sum '((1 2) (3 4) (5 6) (7 8)) '((10 20) (30 40) (50 60) (70 80))) ;; '((11 22) (33 44) (55 66) (77 88))

;; === distance ===

;; This should not be done! (but it helps)
(define graph '((a c 5) (b e 8) (c b 3) (c d 8) (d e 2) (e c 6) (e f 7)))

(define (distance graph path)
	(display "Not yet implemented\n")
)

(display "=== distance ===\n")
(distance graph '((a c) (c b) (b e) (e f))) ;; 23
(distance graph '((a c) (c d) (d e) (e c) (c b) (b e) (e f))) ;; 39
(distance graph '((c b) (b e))) ;; 11

;; === mul ===

(define (mul mA mB)
	(display "Not yet implemented\n")
)

(display "=== mul ===\n")
(mul '((1 2 3) (4 5 6) (7 8 9)) '((1 2 3) (4 5 6) (7 8 9))) ;; '((30 36 42) (66 81 96) (102 126 150))
(mul '((1 2) (3 4) (5 6) (7 8)) '((1 2 3) (4 5 6))) ;; '((9 12 15) (19 26 33) (29 40 51) (39 54 69))
(mul '() '()) ;; '()

;; === toDense ===

(define (toDense matrix)
  (map (lambda(x)(filter (lambda(x)(> x 0)) x)) matrix)
)

(display "=== toDense ===\n")
(toDense '((1 2 3 4) (5 6 0 0) (7 8 9 0) (10 0 0 0))) ;; '((1 2 3 4) (5 6) (7 8 9) (10))
(toDense '((1 2 3) (0 0 0) (4 5 0))) ;; '((1 2 3) () (4 5))
(toDense '((1 2 3 4 5) (0 6 7 0 0) (8 9 10 11 12) (13 0 0 0 0))) ;; '((1 2 3 4 5) (6 7) (8 9 10 11 12) (13))

;; === pass? ===

;; This should not be done! (but it helps)
(define grades '((796623 62 84 91) (782544 81 89 77) (790256 59 62 63) (799610 75 68 82) (791313 85 56 92) (786621 98 97 92) (809706 91 72 80)))

(define (pass-aux grades)
  (>= (/ (apply + grades) (length grades)) 70)
)

(define (pass? id grades)
  (if(= id (caar grades))
     (pass-aux(cdar grades))
     (pass? id (cdr grades))
  )
)

(display "=== pass? ===\n")
(pass? 791313 grades) ;; #t
(pass? 790256 grades) ;; #f
(pass? 782544 grades) ;; #t

;; === sort ===

(define (sort table)
	(display "Not yet implemented\n")
)

(display "=== sort ===\n")
(sort '((796623 92) (782544 83) (790256 62) (799610 75) (791313 85) (786621 98) (809706 94))) ;; '((790256 62) (799610 75) (782544 83) (791313 85) (796623 92) (809706 94) (786621 98))