#lang racket

;ACTIVITY 2

;Sum of elements in a list
(define(sumElements lst)
  (if(null? lst)
     0
     (if(number?(car lst))
       (+ (car lst) (sumElements (cdr lst)))
       (sumElements(cdr lst))
     )
  )
)

;Palindrome
(define (palindrome lst)
  (equal? (reverse lst) lst)
)

;Reversing a list
(define (reversing lst)
  (if(null? lst)
     '()
     (append(reversing(cdr lst)) (list(car lst)))
  )
)

;Accessing and index in a list
(define(access-index index lst)
  (if(and(>= index 0) (< index (length lst)))
     (if(= index 0)
         (car lst)
         (access-index(- index 1)(cdr lst))
     )
     null
  )
)

;Extracting elements in odd position of a list
(define(odd-position-aux lst flag)
  (if(null? lst)
     '()
     (if(equal? #t flag)
        (append(list(car lst))(odd-position-aux (cdr lst) (not flag))) ;(cons(car lst))
        (odd-position-aux (cdr lst)(not flag))
     )
  ) 
)

(define(odd-position lst)
  (odd-position-aux lst #f)
)

;HOMEWORK 5

;Fibonacci
(define (fibonacci n)
  (if(<= n 1)
     n
     (+(fibonacci(- n 1))(fibonacci(- n 2)))
  )
)

;NestedSum
(define(nestedSum lst)
  (if(null? lst)
     0
     (if(list? (car lst))
        (+ (nestedSum(car lst))(nestedSum(cdr lst)))
        (+ (car lst) (nestedSum(cdr lst)))
     )
  )
)

;EvenNumbers respecting parentesis
(define (evenNumbers lst)
  (if(null? lst)
     null ;'()
     (if(list? (car lst))
        (append(list(evenNumbers(car lst)))(evenNumbers(cdr lst)))
        (if(even?(car lst))
           (append(list(car lst))(evenNumbers(cdr lst)))
           (evenNumbers(cdr lst))
        )
     )
  )
)

;NestedReverse
(define (nestedReverse lst)
  (if(null? lst)
     '()
     (if(list? (car lst))
        (append(nestedReverse(cdr lst))(cons(nestedReverse(car lst))'()))
        (append(nestedReverse(cdr lst))(list(car lst)))
     )
  )
)

;Unroll
(define (unroll lst)
  (if(null? lst)
     '()
     '(if(list?(car lst))
        (append (unroll (car lst)) (unroll (cdr lst)))
        (append(list(car lst))(unroll (cdr lst)))
      )
  )
)
